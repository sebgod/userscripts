" Vim syntax file
" Language:     Mercury
" Maintainer:   Ralph Becket <rafe@cs.mu.oz.au>
" vim: ts=2 sw=2 et

if exists("b:current_syntax")
  finish
endif
let b:current_syntax = "mercury"

set fdm=syntax
if !exists("foldnestmax")
  set foldnestmax=3
endif

if !exists("foldminlines")
  set foldminlines=10
endif
  " Mercury is case sensitive.
  "
syn case match

  " The default highlighting for Mercury comments is to only highlight the
  " initial `%' and subsequent `line' punctuation characters, likewise
  " the /* and */ from C-style comments.
  " To highlight everything including the comment text, add
  "
  " In your .vimrc file, you can specify following options:
  "
  "   let mercury_highlight_full_comment = 1
  "
  " By default, parts of lines that extend over 78 characters will be
  " highlighted.  To avoid this behaviour, add
  "
  "   let mercury_no_highlight_overlong = 1
  "
  " To facilitate better git patch management,
  " spurious whitespace is marked as an erro, to supress these errors, use
  "
  "   let mercury_no_highlight_trailing_whitespace = 1
  "
  " Highlighting of C,Java,C# and Erlang code is supported by default,
  " disable (if you think loading huge files is slow) with:
  "
  "   let mercury_no_highlight_foreign = 1

syn match mercurySingleton      "\v<_([A-Z][a-z_A-Z0-9]*)?>"
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
syn keyword mercuryPragma       does_not_terminate check_termination
syn keyword mercuryPragma       promise_equivalent_clauses
syn keyword mercuryCInterface   foreign_proc foreign_decl foreign_code
syn keyword mercuryCInterface   foreign_type foreign_import_module
syn keyword mercuryCInterface   foreign_export_enum foreign_export
syn keyword mercuryCInterface   foreign_enum
syn keyword mercuryForeignMod   may_call_mercury will_not_call_mercury
syn keyword mercuryForeignMod   thread_safe not_thread_safe maybe_thread_safe
syn keyword mercuryForeignMod   promise_pure promise_semipure
syn keyword mercuryForeignMod   tabled_for_io local untrailed trailed
syn keyword mercuryForeignMod   attach_to_io_state max_stack_size
syn keyword mercuryForeignMod   can_pass_as_mercury_type stable
syn keyword mercuryForeignMod   will_not_throw_exception
syn keyword mercuryForeignMod   may_modify_trail will_not_modify_trail
syn keyword mercuryForeignMod   may_duplicate may_not_duplicate
syn keyword mercuryForeignMod   affects_liveness terminates
syn keyword mercuryForeignMod   does_not_affect_liveness doesnt_affect_liveness
syn keyword mercuryForeignMod   no_sharing unknown_sharing sharing
syn keyword mercuryOperator     div rem mod
syn keyword mercuryImpure       impure semipure
syn keyword mercuryToDo         XXX TODO NOTE MISSING HACK HINT WARNING 
syn keyword mercuryBool         yes no
syn keyword mercuryLogical      some all not if then else true fail or and or_else
syn keyword mercuryLogical      semidet_true semidet_false impure_true
syn keyword mercuryLogical      try catch catch_any semidet_fail
syn match   mercuryImplKeyword  "\v\$(file|grade|pred|module|line|\d+)>"
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
syn match   mercuryOperator     "@"
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
syn match   mercuryOperator     "/"
syn match   mercuryOperator     "//"
syn match   mercuryOperator     "*"
syn match   mercuryOperator     "\^"
syn match   mercuryTerminator   "\v\.($|\s+)"
syn match   mercuryImplication  "<=>\|<=\|=>"
  " XXX Technically, Mercury numbers do not have integer literal suffixes, but it shouldn't
  " hurt to include them here (for the C, C#, Java grades).
syn match   mercuryNumCode /\v<(0'.|0b[01]+|0o[0-7]+|0x[0-9a-fA-F]+|[0-9]+(\.[0-9]+([eE][-+]?[0-9]+)?)?)[lLfFm]?>/
syn region  mercuryAtom         start=+'+ skip=+\\.+ end=+'+
syn region  mercuryString       start=+"+ skip=+\\.+ end=+"+       contains=mercuryStringFmt,@mercuryFormatting
syn match   mercuryStringFmt    /\\[abfnrtv\\"]\|\\x[0-9a-fA-F]\+\\\|%[-+# *.0-9]*[dioxXucsfeEgGp]/      contained
syn region  mercuryInlined   matchgroup=mercuryOperator  start='`' end='`'
  " first matching only a closing bracket, to catch unbalanced brackets
syn match mercuryMisInList "}\|)" contained
syn match mercuryMisInBlock "}\|]" contained
syn match mercuryMisInDCGAction "]\|)" contained
syn match mercuryMisInAny "\v\.(\s+|$)" contained

if !exists("mercury_no_highlight_overlong") || !mercury_no_highlight_overlong
  syn match mercuryTooLong /\%79v[^")}\]%]*/
  syn cluster mercuryFormatting add=mercuryTooLong
endif
  " The clusters contain all valid Mercury code. The nesting is done to allow
  " for matching of parens, DCG terms and lists
syn cluster mercuryTerms     contains=mercuryBlock,mercuryList,mercuryString,mercuryDelimiter,
  \ mercuryAtom,mercuryNumCode,mercuryComment,mercuryKeyword,mercuryImplKeyword,@mercuryFormatting,mercuryMisInAny,
  \ mercuryCComment,mercuryBool,mercuryOperator,mercurySingleton,mercuryImplication,mercuryInlined
syn cluster mercuryCode      contains=@mercuryTerms,mercuryLogical
syn region  mercuryList      matchgroup=mercuryBracket   start='\[' end=']' transparent fold  contains=@mercuryTerms,mercuryForeignMod,mercuryMisInList
syn region  mercuryBlock     matchgroup=mercuryBracket   start='(' end=')'  transparent fold  contains=@mercuryCode,mercuryDCGAction,mercuryMisInBlock
syn region  mercuryDCGAction matchgroup=mercuryBracket   start='{' end='}'  transparent fold  contains=@mercuryCode,mercuryMisInDCGAction

if !exists("mercury_no_highlight_foreign") || !mercury_no_highlight_foreign
    " Basic syntax highlighting for foreign code
  syn match mercuryForeignParen "(\|)" contained
  syn cluster mercuryForeign contains=mercuryList,mercuryCInterface,mercuryKeyword,mercuryOperator,mercuryForeignLangId,mercuryForeignParen,mercuryAtom,mercuryComment,mercuryDelimiter

    " C-Style syntax as a basis for C,C# and Java
  syn keyword mercuryCLikeKeyword if else goto switch case for while do break continue return volatile extern typedef static default contained
  syn keyword mercuryCLikeType void int char long byte unsigned signed struct float double enum contained
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

    " ISO C Language formatting
  syn keyword mercuryCType contained const size_t pid_t offset_t union MR_bool MR_Word MR_Integer
    \ MR_Unsigned MR_ArrayPtr MR_Float MR_file MercuryFile[Ptr]
  syn match mercuryCType "\v<MR_((Pseudo)?TypeInfo|TypeCtor(Desc|Info)|AllocSiteInfoPtr)|MercuryLock>" contained
  syn match mercuryCType "\v<[u]?int(8|16|32|64)_t>" contained
  syn keyword mercuryCKeyword typedef sizeof typeof offsetof contained
  syn keyword mercuryCConst NULL EOF  contained
  syn keyword mercuryCBool MR_TRUE MR_FALSE contained
  syn match mercuryForeignIface "\v<MR_[A-Z]+_LENGTH_MODIFIER>" contained
  syn match mercuryCFunc "\v<MR_(list_(empty|head|tail)|incr_hp((_atomic)?|((_type)?_msg))|assert|fatal_error|make_aligned_string)>" contained
  syn match mercuryCPreProc "#\(if\(n\?def\)\?\|else\|elif\|endif\|define\|include\|error\|warning\|line\)" contained
  syn match mercuryCPreProc "\v(\\){1,2}$" contained
  syn match mercuryCStringFmt    +%[-+# *.0-9]*[dioxXucsfeEgGp]+                                contained
  syn region mercuryCString start=+""+ end=+""+ contained contains=mercuryCStringFmt,mercuryCLikeCharEsc
  syn cluster mercuryC contains=@mercuryCLike,mercuryCType,mercuryCKeyword,mercuryCPreProc,mercuryCString,mercuryCBool,mercuryCConst,mercuryCFunc

    " C++-Style for Java and C# (bool, // comments, exception handling etc)
  syn keyword mercuryCppLikeKeyword class new delete try catch finally instanceof abstract throw[s] extends this super base synchronize[d] override foreach in contained
  syn keyword mercuryCppLikeBool true false contained
  syn keyword mercuryCppLikeConst null[ptr] contained
  syn match mercuryCppLikeOperator "@" contained
  syn match mercuryCppLikeType "\v<((io|runtime)\.(\_\s+)?)?(MR_)[A-Za-z_0-9]+>" contained
  syn keyword mercuryCppLikeMod public private protected internal virtual final readonly volatile transient contained
  syn cluster mercuryCppLike contains=@mercuryC,mercuryCppLikeComment,mercuryCppLikeKeyword
  syn cluster mercuryCppLike add=mercuryCppLikeBool,mercuryCppLikeMod,mercuryCppLikeConst,mercuryCppLikeType,mercuryCppLikeOperator

    " Declaration for ISO C
  syn region mercuryCCode      matchgroup=mercuryString start=+"+ skip=+""+ end=+"+ transparent fold contained contains=@mercuryC
  syn region mercuryCDecl start=/\v^:-\s+pragma\s+foreign_\w+\(("C"|c)/ matchgroup=mercuryDelimiter end="\v[)]\.($|\s{-})" transparent contains=@mercuryForeign,mercuryCCode
    " Declaration for C#
  syn match mercuryCSharpStringFmt "{[0-9]}" contained
  syn match mercuryCSharpStringFmtEsc "{{\|}}" contained
  syn keyword mercuryCSharpType object string decimal bool contained
  syn match mercuryCSharpType "\v<System\.((IO|Text|Diagnostics)\.)?[A-Z][A-Za-z_0-9]+>"
  syn region mercuryCSharpString start=+""+ end=+""+ contained contains=mercuryCLikeCharEsc,mercuryCSharpStringFmt,mercuryCSharpStringFmtEsc
  syn cluster mercuryCSharp contains=@mercuryCppLike,mercuryCSharpString,mercuryCSharpType
  syn region mercuryCSharpCode matchgroup=mercuryString start=+"+ skip=+""+ end=+"+ transparent fold contained contains=@mercuryCSharp
  syn region mercuryCSharpDecl start=/\v^:-\s+pragma\s+foreign_\w+\("C#"/ matchgroup=mercuryDelimiter end="\v[)]\.($|\s{-})" transparent contains=@mercuryForeign,mercuryCSharpCode

    " Declaration for Java
  syn match mercuryJavaType "\v([a-z_0-9]+\.(\_\s+)?)+[A-Z][A-Z_a-z0-9]+" contained
  syn match mercuryJavaType "\v<(String(Builder)?|Override|Object|Integer|Short|Float|Double|Void|Boolean|Character|System|Runtime|boolean)>" contained
  syn region mercuryJavaCode   matchgroup=mercuryString start=+"+ skip=+""+ end=+"+ transparent fold contained contains=@mercuryCppLike,mercuryCString,mercuryJavaType
  syn region mercuryJavaDecl start=/\v^:-\s+pragma\s+foreign_\w+\(("Java"|java)/ matchgroup=mercuryDelimiter end="\v[)]\.($|\s{-})" transparent contains=@mercuryForeign,mercuryJavaCode

    " Declaration for .NET IL
  syn match mercuryILType "\v<[u]?int(8|16|32|64)|float(32|64)>" contained
  syn cluster mercuryIL contains=@mercuryCSharp,mercuryILType
  syn region mercuryILCode matchgroup=mercuryString start=+"+ skip=+""+ end=+"+ transparent fold contained contains=@mercuryIL
  syn region mercuryILDecl start=/\v^:-\s+pragma\s+foreign_\w+\(("IL"|il)/ matchgroup=mercuryDelimiter end=/\v[)]\.($|\s{-})/ transparent contains=@mercuryForeign,mercuryILCode

    " Declaration for Erlang
  syn keyword mercuryErlangKeyword contained after and andalso band begin bnot bor bsl bsr bxor case
  \ catch cond end fun if let not of orelse query receive throw try when xor
  syn keyword mercuryErlangBool true false
  syn match mercuryErlangOperator "\v[?]" contained
  syn region mercuryErlangString start=+""+ end=+""+ contained
  syn cluster mercuryErlangTerms contains=mercuryErlangBlock,mercuryErlangList,mercuryErlangString,
  \ mercuryCLikeChar,mercuryNumCode,mercuryComment,mercuryKeyword,mercuryErlangKeyword,mercuryErlangOperator,
  \ mercuryCComment,mercuryErlangBool,mercuryOperator,mercurySingleton,mercuryImplication,mercuryErlangDCGAction
  syn region  mercuryErlangList contained matchgroup=mercuryBracket
  \ start='\[' end=']' transparent fold  contains=@mercuryErlangTerms,mercuryMisInList
  syn region  mercuryErlangBlock    contained matchgroup=mercuryBracket
  \ start='(' end=')'  transparent fold  contains=@mercuryErlangTerms,mercuryMisInBlock
  syn region  mercuryErlangDCGAction contained matchgroup=mercuryBracket
  \ start='{' end='}'  transparent fold  contains=@mercuryErlangTerms,mercuryMisInDCGAction
  syn cluster mercuryErlang    contains=@mercuryErlangTerms,mercuryErlangDCGAction,mercuryForeignIface
  syn region mercuryErlangCode   matchgroup=mercuryString start=+"+ skip=+""+ end=+"+
  \ transparent fold contained contains=@mercuryErlang
  syn region mercuryErlangDecl start=/\v^:-\s+pragma\s+foreign_\w+\(("Erlang"|erlang)/
  \ matchgroup=mercuryDelimiter end=/\v[)]\.($|\s{-})/ transparent contains=@mercuryForeign,mercuryErlangCode
    " Matching foreign interface builtins and success indicator
  syn keyword mercuryForeignIface SUCCESS_INDICATOR contained
  syn match mercuryForeignIface "\v<builtin.[A-Z][A-Z_0-9]+>" contained
  syn match mercuryForeignIface "\v<MR_(VERSION|FULLARCH|CYGWIN|WIN32|COMPARE_(LESS|EQUAL|GREATER)|ALLOC_ID)>" contained

    " The language identifier has precedence over the code blocks
  syn match mercuryForeignLangId +"\v(C[#]?|Erlang|IL|Java)"+ contained
endif

if !exists("mercury_no_highlight_trailing_whitespace") || !mercury_no_highlight_trailing_whitespace
  syn match mercuryWhitespace "\v\.?\s+$"
  syn cluster mercuryFormatting add=mercuryWhitespace
endif

  " Comment handling
syn match mercuryCCommentPrefix "\v^\s*[*]{1,2}(\s+|$)" contained
syn match mercuryCommentInfo " \(\(Main \)\?[Aa]uthor[s]\?\|Stability\|File\|Created on\|Date\|Source\):" contained
syn match mercuryCopyrightYear "\v (19|20)[0-9][0-9]([, -]+(19|20)[0-9][0-9])*" contained
syn match mercuryCommentInfo "Copyright (C)" contained nextgroup=mercuryCopyrightYear
syn match mercuryCommentTexQuote "``\|''" contained
syn cluster mercuryCommentDirectives contains=mercuryToDo,mercuryCommentInfo
syn cluster mercuryCommentTex contains=mercuryCommentTexQuote

if exists("mercury_highlight_full_comment") && mercury_highlight_full_comment
  syn region  mercuryComment start="%" end=/\v(\S|\s+\S)*$?/ oneline 
  \ contains=@mercuryCommentDirectives,@mercuryCommentTex,@mercuryFormatting
  syn region  mercuryCComment       matchgroup=mercuryComment start="/\*" end="\*/"
  \ fold  contains=@mercuryCommentDirectives,mercuryCCommentPrefix,@mercuryFormatting
  syn region  mercuryCppLikeComment matchgroup=mercuryComment start="//"  end=/\v(\S|\s+\S)*$?/
  \ oneline  contained contains=@mercuryCommentDirectives,@mercuryFormatting
else
  syn region  mercuryComment start=+%[-=%*_]*+ matchgroup=NONE end=/\v(\S|\s+\S)*$?/he=s-1 oneline contains=@mercuryCommentDirectives,@mercuryFormatting
  syn region  mercuryCComment matchgroup=mercuryComment start="\v/\*([-*]+$){0,1}" end="[-*]*\*/"
  \ transparent fold  contains=@mercuryCommentDirectives,mercuryCCommentPrefix,@mercuryFormatting
  syn region  mercuryCppLikeComment matchgroup=mercuryComment start="//"
  \ matchgroup=NONE end=/\v(\S|\s+\S)*$?/ transparent oneline contained contains=@mercuryCommentDirectives,@mercuryFormatting
endif

  " Matching the output of the error command in extras
syn region  mercuryCComment      matchgroup=mercuryError start="/\* ###" end="\v[^*]+\*/"         oneline

  " Matching Vim modeline
syn match mercuryModelineParam "\v(sw|ts|tw|wm|ff|ft)\=" contained
syn match mercuryModelineParam "\vet|expandtab" contained
syn match mercuryModelineValue "\<\(mercury\|unix\)\>" contained
syn region mercuryModeline matchgroup=mercuryComment  start="% vim:" end=+$+     oneline contains=mercuryModelineParam,mercuryModelineValue,mercuryNumCode
syn region mercuryShebang matchgroup=mercuryComment  start="\v^#!/" end=/\v.+$/     oneline

syn sync fromstart

hi link mercuryAccess           Identifier
hi link mercurySingleton        Identifier
hi link mercuryAtom             Constant
hi link mercuryBracket          mercuryDelimiter
hi link mercuryBool             Special
hi link mercuryComment          Comment
hi link mercuryCommentInfo      Identifier
hi link mercuryCommentTexQuote  Special
hi link mercuryCopyrightYear    Constant
hi link mercuryCComment         mercuryComment
hi link mercuryCCommentPrefix   mercuryComment
hi link mercuryCInterface       mercuryPragma
if !exists("mercury_no_highlight_foreign") || !mercury_no_highlight_foreign
  hi link mercuryForeignLangId    Identifier
  hi link mercuryCLikeBracket     mercuryBracket
  hi link mercuryCLikeOperator    mercuryOperator
  hi link mercuryCLikeChar        mercuryAtom
  hi link mercuryCLikeCharEsc     Identifier
  hi link mercuryCLikeDelimiter   mercuryDelimiter
  hi link mercuryCLikeKeyword     Keyword
  hi link mercuryCLikeString      mercuryString
  hi link mercuryCppLikeType      Type
  hi link mercuryCLikeType        Type
  hi link mercuryCBool            mercuryBool
  hi link mercuryCConst           Constant
  hi link mercuryCFunc            Identifier
  hi link mercuryCKeyword         Keyword
  hi link mercuryCStringFmt       mercuryStringFmt
  hi link mercuryCType            Type
  hi link mercuryCPreProc         mercuryPragma
  hi link mercuryCppLikeBool      mercuryBool
  hi link mercuryCppLikeConst     Constant
  hi link mercuryCppLikeKeyword   Keyword
  hi link mercuryCppLikeMod       mercuryAccess
  hi link mercuryCppLikeOperator  mercuryOperator
  hi link mercuryCString          mercuryString
  hi link mercuryCSharpString     mercuryString
  hi link mercuryCSharpStringFmt  mercuryStringFmt
  hi link mercuryCSharpStringFmtEsc Identifier
  hi link mercuryCSharpType       Type
  hi link mercuryJavaType         Type
  hi link mercuryILType           Type
  hi link mercuryErlangKeyword    Keyword
  hi link mercuryErlangOperator   Operator
  hi link mercuryErlangBool       mercuryBool
  hi link mercuryErlangString     mercuryString
endif
hi link mercuryDelimiter        Delimiter
hi link mercuryError            ErrorMsg
hi link mercuryImpure           Special
hi link mercuryImplKeyword      Underlined
hi link mercuryKeyword          Keyword
hi link mercuryModelineParam    Identifier
hi link mercuryModelineValue    Constant
hi link mercuryNumCode          Constant
hi link mercuryPragma           PreProc
hi link mercuryForeignMod       mercuryForeignIface
hi link mercuryForeignOperator  mercuryOperator
hi link mercuryForeignIface     Identifier
hi link mercuryForeignParen     mercuryDelimiter
hi link mercuryImplication      Special
hi link mercuryLogical          Special
hi link mercuryMisInList        ErrorMsg
hi link mercuryMisInBlock       ErrorMsg
hi link mercuryMisInDCGAction   ErrorMsg
hi link mercuryMisInAny         ErrorMsg
hi link mercuryOperator         Operator
hi link mercuryInlined          Operator
hi link mercuryString           String
hi link mercuryStringFmt        Special
hi link mercuryToDo             Todo
hi link mercuryTooLong          mercuryError
hi link mercuryWhitespace       mercuryError
hi link mercuryTerminator       Delimiter
hi link mercuryType             Type
