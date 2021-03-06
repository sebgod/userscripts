:- module(ucd2tab, [
                    parse_scripts/2,
                    script//1,
                    group/2,
                    compact_range/2,
                    compact_ranges/2,
                    is_script_part/1,
                    char_script/2
                   ]).

:- use_module(ucd_ranged_parser).
:- use_module(library(pio)).
:- use_module(library(assoc)).

:- dynamic is_in_range/2.

script(Ls) --> lines(Ls).

line(C) --> comment(C), !.
line(E) --> entry(E), !.

lines([L | Ls]) --> line(L), !, "\n", lines(Ls).
lines(Ls) --> "\n", !, lines(Ls).
lines([]) --> [], !.

semi --> ws, ";", ws.
sharp --> ws, "#", ws.

entry(entry(single(C), Script, Class, name(Name))) -->
    codepoint(C),
    semi,
    !,
    script_name(Script),
    sharp,
    class(Class),
    ws,
    char_name(Name).
entry(entry(R, Script, Class, name(From, To))) -->
    range(R),
    semi,
    script_name(Script),
    sharp,
    class(Class),
    count(_),
    char_name(From), "..", char_name(To).


is_script_part(C) :- code_type(C, csym).
script_name(Script) --> generic_name(ucd2tab:is_script_part, Script).

class(Class) --> [H, L], { atom_codes(Class, [H, L]) }.

is_char_part(C) :- code_type(C, alnum); C = 32; C=45.
char_name(control(I)) --> "<control-", !, codepoint(I), ">".
char_name(Name) --> generic_name(ucd2tab:is_char_part, Name).

range(range(From, To)) --> codepoint(From), "..", codepoint(To).
count(C) --> ws, "[", integer(C), "]", ws.

parse_scripts(File, E) :- phrase_from_file(script(E) , File, [encoding(utf8)]).

group(Entries, Groups) :-
	empty_assoc(Empty),
	group_add(Entries, Empty, Groups).

group_add([], Assoc, Assoc) :- !.
group_add([Entry | Entries], Prev, New) :-
	Entry = entry(_Chars, Script, _Class, _Name),
	!,
	(   get_assoc(Script, Prev, PList ), ! ; PList = []),
	append(PList, [Entry], NList),
	put_assoc(Script, Prev, NList, Temp),
        group_add(Entries, Temp, New).
group_add([_ | Entries], Prev, New) :- group_add(Entries, Prev, New).

entry_to_range(entry(single(Char), _, _, _), Char, Char).
entry_to_range(entry(range(Start, End), _, _, _), Start, End).

compact_range(Prev, Compact) :- compact_range_accum([], Prev, Compact).
compact_range_accum([], [E | Entries], Compact) :-
	entry_to_range(E, Start, End),
	Range = range(Start, End),
	compact_range_accum(Range, Entries, Compact).
compact_range_accum(range(LStart, LEnd), [Entry | Entries], Cs) :-
	L1 is LEnd + 1,
	entry_to_range(Entry, Start, End),
	(   L1 = Start -> compact_range_accum(range(LStart, End), Entries, Cs)
	;   compact_range_accum(range(Start, End), Entries, COther),
	    Cs = [range(LStart, LEnd) | COther]
	).
compact_range_accum(L, [], [L]).

compact_ranges(Groups, Compact) :-
	map_assoc(compact_range, Groups, Compact).

char_counts(_, [], []).
char_counts(Tree, [Script | Scripts], [indexByCount(Count, Script, Ranges) | Counts]) :-
	get_assoc(Script, Tree, Ranges),
	char_count(Ranges, Count),
	char_counts(Tree, Scripts, Counts).

char_count(Ranges, Count) :- char_count_acc(Ranges, C), Count is C.
char_count_acc([], 0).
char_count_acc([range(Start, End) | Ranges], (End - Start) + 1 + Count) :- char_count(Ranges, Count).


script_list(Groups, Scripts) :-
	assoc_to_keys(Groups, Scripts).

bag_ranges(Counts) :-
        retractall(is_in_range(_,_)),
	member(indexByCount(_Count, Script, Ranges), Counts),
	    forall(member(range(Start, End), Ranges), bag_range(Start, End, Script)),
	fail.
% turn implicit linking to explicit
bag_ranges(_) :-
	char_range(Max, 0x10ffff),
	between(0, Max, I),
	    not(is_in_range(I, _)),
	    findall(Below, (is_in_range(Below, [_ | _]), Below < I), Belows ),
	    last(Belows, Last),
	    assert(is_in_range(I, Last)),
	fail.
bag_ranges(_).

:- dynamic log2factor/1.
:- retractall(log2factor(_)), log(2, Log2), Inv is 1/Log2, assert(log2factor(Inv)).
bag_range(Start, End, Script) :-
	char_range(CardMin, Start),
	ored_pattern(Start, End, Pattern),
	(   is_in_range(CardMin, Prev) -> retractall(is_in_range(CardMin, _)) ; Prev = [] ),
	RDs = [rangeDesc(Pattern, Start, End, Script) | Prev],
	assert(is_in_range(CardMin, RDs)).

char_range(CharMin, Code) :-
	(   Code = 0 -> CodeLog = 0 ; log(Code, CodeLog)),
	log2factor(TwoLog),
	CharMin is floor(CodeLog * TwoLog).

char_script(Char, Script) :-
	char_code(Char, Code),
	char_range(CharMin, Code),
	is_in_range(CharMin, RangeParam),
	!,
	(   atomic(RangeParam) -> is_in_range(RangeParam, RDs) ; RDs = RangeParam),
	char_script(Code, RDs, Script).

char_script(_, [], 'Unknown').
char_script(Code, [rangeDesc(Pattern, RangeStart, RangeEnd, Script) | _], Script) :-
	    0 =:= \Pattern /\ Code,
	    RangeStart =< Code,
	    RangeEnd >= Code,
	    !.
char_script(Code, [_ | RDs], Script) :- char_script(Code, RDs, Script).


ored_pattern(P, P, P) :- !.
ored_pattern(Start, End, Pattern) :-
	ored_pattern(Start, End, Start, 0, Pattern).
ored_pattern(_, End, End, Pattern, Pattern) :- !.
ored_pattern(Start, End, I, In, Out) :-
	Temp is In \/ I,
	I1 is I +1,
	ored_pattern(Start, End, I1, Temp, Out).

convert_file(InputFile, OutputFile) :-
    parse_scripts(InputFile, Parsed),
    group(Parsed, Tree),
    script_list(Tree, Scripts),
    compact_ranges(Tree, Compact),
    char_counts(Compact, Scripts, Counts),
    msort(Counts, Sorted),
    reverse(Sorted, Desc),
    bag_ranges(Desc).

:- absolute_file_name('../../data/UCD/scripts.txt', ScriptFile),
   absolute_file_name('../../data/UCD/scripts.tab', TabFile),
   convert_file(ScriptFile, TabFile).

:- begin_tests(scripts).
test('你-han', CharScript == 'Han') :- char_script('你', CharScript).
test('a-latin', CharScript == 'Latin') :- char_script('a', CharScript).

:- end_tests(scripts).
