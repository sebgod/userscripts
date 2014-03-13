" Vim syntax file
" Language:     Mercury
" Maintainer:   Ralph Becket <rafe@cs.mu.oz.au>
" vim: ts=2 sw=2 et

if exists("b:current_syntax")
  finish
endif
let b:current_syntax = "mercury"

set fdm=syntax
set foldnestmax=3
set foldminlines=10
  " Mercury is case sensitive.
  "
syn case match

  " The default highlighting for Mercury comments is to only highlight the
  " initial `%' and subsequent `line' punctuation characters.  To highlight
  " everything including the comment text, add
  "
  "   let mercury_highlight_full_comment = 1
  "
  " somewhere in your `.vimrc' file.
  "
  " By default, parts of lines that extend over 80 characters will be
  " highlighted.  To avoid this behaviour, add
  "
  "   let mercury_no_highlight_overlong = 1
  "
  " somewhere in your `.vimrc' file.

syn keyword mercuryAnyVar       _
syn keyword mercuryKeyword      module use_module import_module
syn keyword mercuryKeyword      include_module end_module
syn keyword mercuryKeyword      initialise mutable
syn keyword mercuryKeyword      initialize finalize finalise
syn keyword mercuryKeyword      interface implementation
syn keyword mercuryKeyword      pred mode func type inst solver any_pred any_func
syn keyword mercuryKeyword      is semidet det nondet multi erroneous failure
syn keyword mercuryKeyword      cc_nondet cc_multi
syn keyword mercuryKeyword      typeclass instance where
syn keyword mercuryKeyword      pragma promise external
syn keyword mercuryKeyword      trace atomic
syn keyword mercuryKeyword      require_complete_switch
syn keyword mercuryKeyword      require_det require_semidet require_multi 
syn keyword mercuryKeyword      require_nondet require_cc_multi require_cc_nondet
syn keyword mercuryKeyword      require_erroneous require_failure
syn keyword mercuryPragma       inline no_inline
syn keyword mercuryPragma       type_spec source_file fact_table obsolete
syn keyword mercuryPragma       memo loop_check minimal_model
syn keyword mercuryPragma       terminates does_not_terminate check_termination
syn keyword mercuryPragma       promise_equivalent_clauses
syn keyword mercuryCInterface   foreign_proc foreign_decl foreign_code
syn keyword mercuryCInterface   foreign_type foreign_import_module
syn keyword mercuryCInterface   foreign_export_enum foreign_export
syn keyword mercuryCInterface   foreign_enum
syn keyword mercuryForeignMod   may_call_mercury will_not_call_mercury
syn keyword mercuryForeignMod   thread_safe not_thread_safe maybe_thread_safe
syn keyword mercuryForeignMod   promise_pure promise_semipure
syn keyword mercuryForeignMod   tabled_for_io local untrailed trailed
syn keyword mercuryForeignMod   attach_to_io_state
syn keyword mercuryForeignMod   can_pass_as_mercury_type stable
syn keyword mercuryForeignMod   will_not_throw_exception
syn keyword mercuryForeignMod   may_modify_trail will_not_modify_trail
syn keyword mercuryForeignMod   may_duplicate may_not_duplicate
syn keyword mercuryForeignMod   affects_liveness
syn keyword mercuryForeignMod   does_not_affect_liveness doesnt_affect_liveness
syn keyword mercuryForeignMod   no_sharing unknown_sharing sharing
syn keyword mercuryOperator     div rem mod
syn keyword mercuryImpure       impure semipure
syn keyword mercuryToDo         XXX TODO NOTE         
syn keyword mercuryBool         true false
syn keyword mercuryLogical      some all not if then else fail or and or_else
syn keyword mercuryLogical      try catch catch_any
syn keyword mercuryLogical      semidet_true semidet_false semidet_fail
syn keyword mercuryLogical      impure_true
syn match   mercuryDelimiter    ","
syn match   mercuryOperator     "-"           " substraction operator or unary minus
syn match   mercuryOperator     "="           " unification
syn match   mercuryOperator     "|"           " cons
syn match   mercuryImplication  "->"          " 'then' arrow
syn match   mercuryOperator     "-->"         " DCG clause
syn match   mercuryOperator     "--->"        " 'typedef'
syn match   mercuryOperator     "\\"
syn match   mercuryLogical      "\\+"         " logical not
syn match   mercuryImplication  "\\/"
syn match   mercuryImplication  "/\\"
syn match   mercuryOperator     "=\.\."
syn match   mercuryOperator     "=<"
syn match   mercuryOperator     "=\\="
syn match   mercuryOperator     "@<"
syn match   mercuryOperator     "@=<"
syn match   mercuryOperator     "@>"
syn match   mercuryOperator     "@>="
syn match   mercuryOperator     ">="
syn match   mercuryOperator     ">"
syn match   mercuryOperator     ">>"
syn match   mercuryOperator     "<"
syn match   mercuryOperator     "<<"
syn match   mercuryOperator     "\\="
syn match   mercuryOperator     "\\=="
syn match   mercuryOperator     "\~="
syn match   mercuryOperator     ":="
syn match   mercuryOperator     ":-"
syn match   mercuryOperator     "=:="
syn match   mercuryOperator     "![:.]\?"
syn match   mercuryImplication  ";"
syn match   mercuryOperator     "+"          " addition operator or unary plus
syn match   mercuryOperator     "++"         " concat operator
syn match   mercuryOperator     "::"
syn match   mercuryOperator     "&"
syn match   mercuryOperator     "?-"
syn match   mercuryOperator     "//"
syn match   mercuryOperator     "*"
syn match   mercuryOperator     "\^"
syn match   mercuryTerminator   "\v\.($|\s+)"
syn match   mercuryImplication  "<=>\|<=\|=>"
syn match   mercuryNumCode      /\v<(0'.|0b[01]+|0o[0-7]+|0x[0-9a-fA-F]+|[0-9]+)>/
syn region  mercuryAtom         start=+'+ skip=+\\.+ end=+'+
syn region  mercuryString       start=+"+ skip=+\\.+ end=+"+       contains=mercuryStringFmt
syn match   mercuryStringFmt    +\\[abfnrtv\\"]\|\\x[0-9a-fA-F]*\\\|%[-+# *.0-9]*[dioxXucsfeEgGp]+      contained
syn cluster mercuryTerms     contains=mercuryBlock,mercuryList,mercuryString,mercuryAtom,mercuryNumCode,mercuryComment,mercuryKeyword
syn cluster mercuryTerms     add=mercuryCComment,mercuryBool,mercuryOperator,mercuryAnyVar,mercuryImplication
syn cluster mercuryCode      contains=@mercuryTerms,mercuryLogical
syn region  mercuryList      matchgroup=mercuryBracket   start='\[' end=']' transparent fold  contains=@mercuryTerms,mercuryForeignMod
syn region  mercuryBlock     matchgroup=mercuryBracket   start='(' end=')'  transparent fold  contains=@mercuryCode
syn region  mercuryDCGAction matchgroup=mercuryBracket   start='{' end='}'  transparent fold  contains=@mercuryCode
syn region  mercuryInlined   matchgroup=mercuryOperator  start='`' end='`'

if !exists("mercury_no_highlight_overlong") || !mercury_no_highlight_overlong
  " The complicated regexp here matches an 80-column string,
  " with proper treatment of tabs (assuming the tab size is 4):
  " each row consists of 20 columns, and each column consists of either 4
  " non-tab characters, or 0-4 non-tab characters followed by a tab.
  syn match   mercuryFirst80 +^\([^	]\{4}\|[^	]\{0,3}	\)\{20}+                                contains=ALL
  syn match   mercuryTooLong +^\([^	]\{4}\|[^	]\{0,3}	\)\{20}..*+                             contains=mercuryFirst80
endif

  " Basic syntax highlighting for foreign code
syn match mercuryForeignParen "(\|)" contained
syn cluster mercuryForeign contains=mercuryList,mercuryCInterface,mercuryKeyword,mercuryOperator,mercuryForeignLangId,mercuryForeignParen
syn keyword mercuryForeignIface SUCCESS_INDICATOR contained

  " C-Style syntax as a basis for C,C# and Java
syn keyword mercuryCLikeKeyword if else goto switch case for while do break continue return volatile extern typedef static contained
syn keyword mercuryCLikeType void null int char long byte unsigned signed struct float double enum contained
syn match mercuryCLikeDelimiter ";," contained
syn match mercuryCLikeOperator "[!-+=*/><~?:]" contained
syn match mercuryCLikeOperator "[!-+=*/><]\?=" contained
syn match mercuryCLikeOperator "--\|++" contained
syn match mercuryCLikeOperator "|\{1,2}\|&\{1,2}" contained
syn match mercuryCLikeBracket  "\[\|]" contained
syn match mercuryCLikeBracket  "[{}()]" contained
syn match mercuryCLikeCharEsc +\\\\\([abfnrtv]\|0[0-7]*\|[xuU][0-9a-fA-F]*\)+ contained
syn region mercuryCLikeChar start=+'+ end=+'+ contained contains=mercuryCLikeCharEsc
syn cluster mercuryCLike contains=mercuryCLikeKeyword,mercuryCLikeType,mercuryCLikeOperator,mercuryCComment,mercuryCLikeChar
syn cluster mercuryCLike add=mercuryNumCode,mercuryCLikeBracket,mercuryCLikeDelimiter,mercuryForeignIface

  " C99 Language formatting
syn keyword mercuryCType size_t offset_t union MR_bool MR_Word MR_Integer MR_Float contained
syn keyword mercuryCKeyword typedef sizeof typeof offsetof contained
syn keyword mercuryCConst NULL EOF contained
syn keyword mercuryCBool MR_TRUE MR_FALSE contained
syn cluster mercuryCPredef contains=mercuryCBool,mercuryCConst
syn match mercuryCPreProc "#\(if\(n\?def\)\?\|else\|elif\|endif\|define\|include\|error\|warning\|line\)" contained
syn match mercuryCStringFmt    +%[-+# *.0-9]*[dioxXucsfeEgGp]+                                contained
syn region mercuryCString start=+""+ end=+""+ contained contains=mercuryCStringFmt,mercuryCLikeCharEsc
syn cluster mercuryC contains=@mercuryCLike,@mercuryCPredef,mercuryCType,mercuryCKeyword,mercuryCPreProc,mercuryCString

" C++-Style for Java and C# (bool, // comments, exception handling etc)
syn keyword mercuryCppLikeKeyword new delete try catch instanceof abstract throw[s] extends contained
syn keyword mercuryCppLikeBool true false contained
syn keyword mercuryCppLikeMod public private protected internal virtual final readonly contained
syn cluster mercuryCppLike contains=@mercuryC,mercuryCppLikeComment,mercuryCppLikeKeyword,mercuryCppLikeBool,mercuryCppLikeMod

  " Declaration for C99
syn region mercuryCCode      matchgroup=mercuryString start=+"+ skip=+""+ end=+"+ transparent fold contained contains=@mercuryC
syn region mercuryCDecl start=/\v^:-\s+pragma\s+foreign_\w+\(("C"|c)/ matchgroup=mercuryDelimiter end="\v[)]\.($|\s+)" transparent contains=@mercuryForeign,mercuryCCode

  " Declaration for C#
syn match mercuryCSharpStringFmt "{[0-9]}" contained
syn match mercuryCSharpStringFmtEsc "{{\|}}" contained
syn region mercuryCSharpString start=+""+ end=+""+ contained contains=mercuryCLikeCharEsc,mercuryCSharpStringFmt,mercuryCSharpStringFmtEsc
syn region mercuryCSharpCode matchgroup=mercuryString start=+"+ skip=+""+ end=+"+ transparent fold contained contains=@mercuryCppLike,mercuryCSharpString
syn region mercuryCSharpDecl start=/\v^:-\s+pragma\s+foreign_\w+\("C#"/ matchgroup=mercuryDelimiter end="\v[)]\.($|\s+)" transparent contains=@mercuryForeign,mercuryCSharpCode

  " Declaration for Java
syn region mercuryJavaCode   matchgroup=mercuryString start=+"+ skip=+""+ end=+"+ transparent fold contained contains=@mercuryCppLike,mercuryCString
syn region mercuryJavaDecl start=/\v^:-\s+pragma\s+foreign_\w+\(("Java"|java)/ matchgroup=mercuryDelimiter end="\v[)]\.($|\s+)" transparent contains=@mercuryForeign,mercuryJavaCode

  " Declaration for Erlang
syn cluster mercuryErlang contains=mercuryComment,mercuryCLikeChar,mercuryOperator,mercuryCString
syn cluster mercuryErlang add=mercuryImplication,mercuryList,mercuryDCGAction,mercuryBlock
syn region mercuryErlangCode   matchgroup=mercuryString start=+"+ skip=+""+ end=+"+ transparent fold contained contains=@mercuryErlang
syn region mercuryErlangDecl start=/\v^:-\s+pragma\s+foreign_\w+\(("Erlang"|erlang)/ matchgroup=mercuryDelimiter end="\v[)]\.($|s+)" transparent contains=@mercuryForeign,mercuryErlangCode

  " The language identifier has precedence over the code blocks
syn match mercuryForeignLangId +"\v(C[#]?|Erlang|IL|Java)"+ contained

if !exists("mercury_no_highlight_trailing_whitespace") || !mercury_no_highlight_trailing_whitespace
  syn match mercuryWhitespace "\v\s+$"
endif

if !exists("mercury_allow_tabs") || !mercury_allow_tabs
  syn match mercuryWhitespace "\v\t+"
endif

  " Comment handling
syn match mercuryCCommentPrefix "\v^\s*[*]{1,2}\s+" contained
syn match mercuryCommentInfo "\(\(Main \)\?[Aa]uthor[s]\?\|Stability\|File\):" contained
syn match mercuryCommentInfo "Copyright (C)" contained
syn cluster mercuryCommentDirectives contains=mercuryToDo,mercuryCommentInfo

if exists("mercury_highlight_full_comment") && mercury_highlight_full_comment
  syn region  mercuryComment                                 start=+%+   end=+.*$+          oneline  contains=@mercuryCommentDirectives
  syn region  mercuryCComment      matchgroup=mercuryComment start=+/\*+ end="\*/"             fold  contains=@mercuryCommentDirectives,mercuryCCommentPrefix
  syn region  mercuryCppLikeComment matchgroup=mercuryComment  start=+//+  end=+.*$+        oneline contained contains=@mercuryCommentDirectives
else
  syn region  mercuryComment                                 start=+%[-=%*_]*+ end=+.*$+he=s-1 oneline  contains=@mercuryCommentDirectives
  syn region  mercuryCComment matchgroup=mercuryComment start="\v/\*([-*]+$){0,1}" end="[-*]*\*/"  transparent fold  contains=@mercuryCommentDirectives,mercuryCCommentPrefix
  syn region  mercuryCppLikeComment matchgroup=mercuryComment start=+//+ matchgroup=NONE end=+.*$+ transparent oneline contained contains=@mercuryCommentDirectives
endif

  " Matching the output of the error command in extras
syn region  mercuryCComment      matchgroup=mercuryError start="/\* ###" end="\v[^*]+\*/"         oneline

  " Matching Vim modeline
syn match mercuryModelineParam "\v(sw|ts|tw|wm|ff|ft)\={-}" contained
syn match mercuryModelineParam "\vet|expandtab" contained
syn region mercuryModeline matchgroup=mercuryComment  start="% vim:" end=+$+     oneline contains=mercuryModelineParam

syn sync fromstart

hi link mercuryAccess           Identifier
hi link mercuryAnyVar           Identifier
hi link mercuryAtom             Constant
hi link mercuryBracket          mercuryDelimiter
hi link mercuryBool             Special
hi link mercuryComment          Comment
hi link mercuryCommentInfo      Identifier
hi link mercuryCComment         mercuryComment
hi link mercuryCCommentPrefix   mercuryComment
hi link mercuryCInterface       mercuryPragma
hi link mercuryCLikeBracket     mercuryBracket
hi link mercuryCLikeOperator    mercuryOperator
hi link mercuryCLikeChar        mercuryAtom
hi link mercuryCLikeCharEsc     Identifier
hi link mercuryCLikeDelimiter   mercuryDelimiter
hi link mercuryCLikeKeyword     Keyword
hi link mercuryCLikeString      mercuryString
hi link mercuryCLikeType        Type
hi link mercuryCBool            mercuryBool
hi link mercruyCConst           Constant
hi link mercuryCKeyword         Keyword
hi link mercuryCStringFmt       mercuryStringFmt
hi link mercuryCType            Type
hi link mercuryCPreProc         mercuryPragma
hi link mercuryCppLikeBool      mercuryBool
hi link mercuryCppLikeKeyword   Keyword
hi link mercuryCppLikeMod       mercuryAccess
hi link mercuryCString          mercuryString
hi link mercuryCSharpString     mercuryString
hi link mercuryCSharpStringFmt  mercuryStringFmt
hi link mercuryCSharpStringFmtEsc Identifier
hi link mercuryDelimiter        Delimiter
hi link mercuryError            ErrorMsg
hi link mercuryImpure           Special
hi link mercuryKeyword          Keyword
hi link mercuryModelineParam    Identifier
hi link mercuryNumCode          Constant
hi link mercuryPragma           PreProc
hi link mercuryForeignMod       mercuryForeignIface
hi link mercuryForeignOperator  mercuryOperator
hi link mercuryForeignIface     Identifier
hi link mercuryForeignParen     mercuryDelimiter
hi link mercuryForeignLangId    Identifier
hi link mercuryLogical          Special
hi link mercuryImplication      Special
hi link mercuryOperator         Operator
hi link mercuryInlined          Operator
hi link mercuryString           String
hi link mercuryStringFmt        Special
hi link mercuryToDo             Todo
hi link mercuryTooLong          mercuryError
hi link mercuryWhitespace       mercuryError
hi link mercuryTerminator       Delimiter
hi link mercuryType             Type
