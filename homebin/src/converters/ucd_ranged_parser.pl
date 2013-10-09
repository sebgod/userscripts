:- module(ucd_ranged_parser, [
		   generic_name//2,
		   integer//1,
		   codepoint//1,
		   ws//0,
		   is_comment_part/1,
		   comment//1]
).

generic_name(Test, Name) --> generic_name_accum(Test, Chars), { atom_codes(Name, Chars) }.
generic_name_accum(Test, [S | Ss]) --> [S], { call(Test, S) }, !, generic_name_accum(Test, Ss).
generic_name_accum(_, []) --> !.

ws --> [W], { code_type(W, space) }, !, ws.
ws --> [], !.

integer(I) --> digit(D0), digits(D), { number_chars(I, [D0|D]) }.

digits([D|T]) --> digit(D), !, digits(T).
digits([]) --> [].
digit(D) --> [D], { code_type(D, digit) }.

codepoint(CAcc) --> codepoint_accum(0, CAcc, 4) | codepoint_accum(0, CAcc, 5) | codepoint_accum(0, CAcc, 6).

codepoint_accum(C, C, 0) --> !.
codepoint_accum(CPrev, CAcc, N) -->
	{ N > 0, N1 is N-1}, [Hex], { code_type(Hex, xdigit(W)), CTemp is CPrev + W*(16**N1) },
	codepoint_accum(CTemp, CAcc, N1).

is_comment_part(C) :- C \= 10.
comment(comment(C)) --> ("# ",! ; "#"), generic_name( is_comment_part, C).
