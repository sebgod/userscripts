" vim: ft=vim ts=2 sw=2 et
" Language:     Mercury
" Maintainer:   Sebastian Godelet <sebastian.godelet+github@gmail.com>
" Extensions:   *.m *.moo
" Last Change:  2014-12-22

if exists("b:current_syntax")
  finish
endif
let b:current_syntax = "mercury"

  " Mercury is case sensitive.
syn case match
set synmaxcol=90

if has("folding") && !exists("mercury_no_folding") || !mercury_no_folding
    " folding is only changed (if not forced) if the Vim default (manual) is active,
    " this avoids conflicts with existing user settings
  if (&fdm == "manual") || (exists("mercury_folding_force") && mercury_folding_force)
    set fdm=indent
  endif
    " the default foldminlines = 1 is not appropriate for Mercury,
    " so we set it higher
  if &foldminlines == 1
    set foldminlines=10
  endif
endif

  " In your .vimrc file, you can specify following options:
  "
  " The default highlighting for  Mercury comments is to only highlight the
  " initial `%' and subsequent `line' punctuation characters, likewise
  " the /* and */ from C-style comments.
  " To highlight everything including the comment text, add:
  "
  "   let mercury_highlight_full_comment = 1
  "
  " By default, parts of lines that extend over 78 characters will be
  " highlighted.  To avoid this behaviour, add:
  "
  "   let mercury_no_highlight_overlong = 1
  "
  " If folding is supported by the running Vim version, the setting of the
  " preferred folding mode for Mercury (currently indent, as it is the fastest)
  " can be disabled by
  "
  "    let mercury_no_folding = 1
  "
  " If you want to force the folding setting to indent (despite other setting in the
  " vimrc file), you can enforce it:
  "
  "    let mercury_folding_force = 1
  "
  " To facilitate better git patch management,
  " spurious whitespace is marked as an error, to suppress these errors, use:
  "
  "   let mercury_no_highlight_trailing_whitespace = 1
  "
  " Highlighting of C,Java,C# and Erlang code is supported by default,
  " disable (if you think loading huge files is slow) with:
  "
  "   let mercury_no_highlight_foreign = 1
  "
  " If you use Vim 7.3+ with conceal enabled but do not want concealing of
  " mathematical operators, use:
  "
  "   let mercury_no_coneal = 1
  "
  " To enable concealing for characters which require a good Unicode font
  " and might be "too much" for some users, define:
  "
  "   let mercury_conceal_extra = 1
  "
  " If concealing of extra characters is enabled, one can additionally
  " enable concealing for logical operators, such as <=> => <= some inf
  " by setting:
  "
  "   let mercury_conceal_logical = 1
  "

syn match mercurySingleton      "\v<_([A-Z][a-z_A-Z0-9]*)?>"
syn keyword mercuryKeyword      any_func
syn keyword mercuryKeyword      any_pred
syn keyword mercuryKeyword      atomic
syn keyword mercuryKeyword      cc_multi
syn keyword mercuryKeyword      cc_nondet
syn keyword mercuryKeyword      det
syn keyword mercuryKeyword      end_module
syn keyword mercuryKeyword      erroneous
syn keyword mercuryKeyword      external
syn keyword mercuryKeyword      failure
syn keyword mercuryKeyword      finalize finalise
syn keyword mercuryKeyword      func
syn keyword mercuryKeyword      implementation
syn keyword mercuryKeyword      import_module
syn keyword mercuryKeyword      include_module
syn keyword mercuryKeyword      initialise initialize
syn keyword mercuryKeyword      inst
syn keyword mercuryKeyword      instance
syn keyword mercuryKeyword      interface
syn keyword mercuryKeyword      is
syn keyword mercuryKeyword      mode
syn keyword mercuryKeyword      module
syn keyword mercuryKeyword      multi
syn keyword mercuryKeyword      mutable
syn keyword mercuryKeyword      nondet
syn keyword mercuryKeyword      or_else
syn keyword mercuryKeyword      pragma
syn keyword mercuryKeyword      pred
syn keyword mercuryKeyword      promise
syn keyword mercuryKeyword      require_cc_multi
syn keyword mercuryKeyword      require_cc_nondet
syn keyword mercuryKeyword      require_complete_switch
syn keyword mercuryKeyword      require_det
syn keyword mercuryKeyword      require_erroneous
syn keyword mercuryKeyword      require_failure
syn keyword mercuryKeyword      require_multi
syn keyword mercuryKeyword      require_nondet
syn keyword mercuryKeyword      require_semidet
syn keyword mercuryKeyword      require_switch_arms_cc_multi
syn keyword mercuryKeyword      require_switch_arms_cc_nondet
syn keyword mercuryKeyword      require_switch_arms_det
syn keyword mercuryKeyword      require_switch_arms_erroneous
syn keyword mercuryKeyword      require_switch_arms_failure
syn keyword mercuryKeyword      require_switch_arms_multi
syn keyword mercuryKeyword      require_switch_arms_nondet
syn keyword mercuryKeyword      require_switch_arms_semidet
syn keyword mercuryKeyword      semidet
syn keyword mercuryKeyword      solver
syn keyword mercuryKeyword      trace
syn keyword mercuryKeyword      type
syn keyword mercuryKeyword      typeclass
syn keyword mercuryKeyword      use_module
syn keyword mercuryKeyword      where

syn keyword mercuryPragma       check_termination
syn keyword mercuryPragma       does_not_terminate
syn keyword mercuryPragma       fact_table
syn keyword mercuryPragma       inline
syn keyword mercuryPragma       loop_check
syn keyword mercuryPragma       memo
syn keyword mercuryPragma       minimal_model
syn keyword mercuryPragma       no_inline
syn keyword mercuryPragma       obsolete
syn keyword mercuryPragma       promise_equivalent_clauses
syn keyword mercuryPragma       source_file
syn keyword mercuryPragma       terminates
syn keyword mercuryPragma       type_spec

syn keyword mercuryCInterface   foreign_code
syn keyword mercuryCInterface   foreign_decl
syn keyword mercuryCInterface   foreign_enum
syn keyword mercuryCInterface   foreign_export
syn keyword mercuryCInterface   foreign_export_enum
syn keyword mercuryCInterface   foreign_import_module
syn keyword mercuryCInterface   foreign_proc
syn keyword mercuryCInterface   foreign_type

syn keyword mercuryForeignMod   affects_liveness
syn keyword mercuryForeignMod     does_not_affect_liveness
syn keyword mercuryForeignMod     doesnt_affect_liveness
syn keyword mercuryForeignMod   attach_to_io_state
syn keyword mercuryForeignMod   can_pass_as_mercury_type stable
syn keyword mercuryForeignMod   may_call_mercury will_not_call_mercury
syn keyword mercuryForeignMod   may_duplicate may_not_duplicate
syn keyword mercuryForeignMod   may_modify_trail will_not_modify_trail
syn keyword mercuryForeignMod   no_sharing unknown_sharing sharing
syn keyword mercuryForeignMod   promise_pure promise_semipure
syn keyword mercuryForeignMod   tabled_for_io local untrailed trailed
syn keyword mercuryForeignMod   thread_safe not_thread_safe maybe_thread_safe
syn keyword mercuryForeignMod   will_not_throw_exception
syn keyword mercuryForeignMod   terminates

syn keyword mercuryPurity       impure
syn keyword mercuryPurity       promise_pure
syn keyword mercuryPurity       promise_semipure
syn keyword mercuryPurity       semipure

syn keyword mercuryToDo         XXX TODO NOTE MISSING HACK HINT WARNING

syn keyword mercuryLogical      fail false true
syn keyword mercuryLogical      if then else
syn keyword mercuryLogical      impure_true
syn keyword mercuryLogical      semidet_fail semidet_false
syn keyword mercuryLogical      semidet_succeed semidet_true
syn keyword mercuryLogical      some all not
syn keyword mercuryLogical      try catch catch_any

syn keyword mercuryBool         yes no
syn keyword mercuryOperator     div rem mod

syn match   mercuryImplKeyword  "\v\$(file|grade|pred|module|line|\d+)>"
syn match   mercuryOperator     "/"           " divide
syn match   mercuryOperator     "//"          " (integer) divide
syn match   mercuryDelimiter    ","           " list seperator or conjunction
syn match   mercuryOperator     "-"           " substraction operator or unary minus
syn match   mercuryOperator     "="           " unification
syn match   mercuryOperator     "|"           " cons
syn match   mercuryImplication  "->"          " 'then' arrow
syn match   mercuryOperator     "-->"         " DCG clause
syn match   mercuryOperator     "--->"        " 'typedef'
syn match   mercuryOperator     "/\\"         " (binary) and
syn match   mercuryOperator     "\\"          " (bitwise) complement
syn match   mercuryOperator     "\\/"         " (binary) or
syn match   mercuryLogical      "\\+"         " logical not
syn match   mercuryOperator     "=\.\."       " Prolog univ
syn match   mercuryOperator     "=<"          " greater equal or contravariant
syn match   mercuryOperator     "=\\="        " not structual equal (for Prolog)
syn match   mercuryOperator     "@"
syn match   mercuryOperator     "@<"
syn match   mercuryOperator     "@=<"
syn match   mercuryOperator     "@>"
syn match   mercuryOperator     "@>="
syn match   mercuryOperator     ">="         " smaller equal or co-variant
syn match   mercuryOperator     ">"          " greater
syn match   mercuryOperator     ">>"         " right shift
syn match   mercuryOperator     "<"          " smaller
syn match   mercuryOperator     "<<"         " left shift
syn match   mercuryOperator     "\\="        " not unify
syn match   mercuryOperator     "\\=="       " not unify (for Prolog)
syn match   mercuryOperator     "\~"
syn match   mercuryOperator     "\~="
syn match   mercuryOperator     ":="         " field update
syn match   mercuryOperator     ":-"         " reverse implication
syn match   mercuryOperator     "=:="        " Structural equality (for Prolog)
syn match   mercuryOperator     "![:.]\?"    " State variable accessors
syn match   mercuryImplication  ";"          " Disjunction
syn match   mercuryOperator     "+"          " addition operator or unary plus
syn match   mercuryOperator     "++"         " concatenation
syn match   mercuryOperator     "::"         " Type/Mode specifier
syn match   mercuryOperator     "&"          " Parallel conjuction
syn match   mercuryOperator     "?-"         " Prolog compatability
syn match   mercuryOperator     "*"          " multiply
syn match   mercuryOperator     "\^"         " field access
syn match   mercuryOperator     /\v`[^`']+`/ " inlined operator
syn match   mercuryImplication  "<=>\|<=\|=>"
syn match   mercuryNumCode /\v<(0'.|0b[01]+|0o[0-7]+|0x\x+|[0-9]+)/
syn match   mercuryFloat   /\v<([0-9]+\.[0-9]+([eE][-+]?[0-9]+)?)/
syn region  mercuryAtom      start=+'+ skip=+\\'+     end=+'+  contains=mercuryStringEsc,@mercuryFormatting,mercuryEscErr
syn region  mercuryString    start=+"+ skip=+\\"\|""+ end=+"+
  \ contains=mercuryStringFmt,mercuryStringEsc,@mercuryFormatting,mercuryEscErr
syn match   mercuryStringFmt    /%[-+# *.0-9]*[dioxXucsfeEgGp]/       contained
syn match   mercuryEscErr "\\[uUx]" contained
syn match   mercuryStringEsc    /\\$/ contained " matching escaped newline
syn match   mercuryStringEsc    /\v\\[abfnrtv\\"]/     contained
syn match   mercuryStringEsc    /\v\\u\x{4}/           contained
syn match   mercuryStringEsc    /\v\\U00(10|0\x)\x{4}/ contained
syn match   mercuryStringEsc    /\v\\x\x+\\/           contained
syn match   mercuryStringEsc    /\v\\[0-7][0-7]+\\/    contained
  " first matching only a closing bracket, to catch unbalanced brackets
syn match mercuryMisInAny       "(\|\[{\|}\|\]\|)"
syn match mercuryMisInAny       "\v\.($|\s+)" contained
syn match mercuryTerminator     "\v\.($|\s+)"
syn match mercuryOperator       "\.\."        " this comes after the mercuryTerminator

  " cf. https://github.com/Twinside/vim-haskellConceal
  " cf. http://rapidtables.com/math/symbols/Basic_Math_Symbols.htm
if has("conceal") && (!exists("mercury_no_conceal") || !mercury_no_conceal)
  hi clear Conceal
  hi def link Conceal mercuryOperator
  set conceallevel=2
  syn match mercuryOperator  "`compose`" conceal cchar=o
  syn match mercuryOperator  ">="        conceal cchar=≥
  syn match mercuryOperator  "=<"        conceal cchar=≤
  syn match mercuryOperator  "\\="       conceal cchar=≠
  if exists("mercury_conceal_extra") && mercury_conceal_extra
      " these characters only display properly on some machines if
      " setglobal ambiw=double
    if has("multi_byte") && (!has("win32") || (exists("ambiw") && ambiw == "double"))
      syn match mercuryOperator  "/\\"          conceal cchar=∧
      syn match mercuryOperator  "\\/"          conceal cchar=∨
      syn match mercuryOperator  "`xor`"        conceal cchar=⊕
      syn match mercuryOperator  "`member`"     conceal cchar=∈
      syn match mercuryOperator  "`contains`"   conceal cchar=∋
      syn match mercuryOperator  "`union`"      conceal cchar=∪
      syn match mercuryOperator  "`intersect`"  conceal cchar=∩
      syn match mercuryOperator  "`difference`" conceal cchar=∆
      syn match mercuryOperator  "`insert`"     conceal cchar=⎀
      syn match mercuryOperator  "`delete`"     conceal cchar=\
      syn match mercuryOperator  "`subset`"     conceal cchar=⊆
      syn match mercuryOperator  "`superset`"   conceal cchar=⊇
    endif
    syn match mercuryOperator  "`x`"       conceal cchar=×
    syn match mercuryOperator  "//"        conceal cchar=÷

       " unforunately, Vim does not allow different conceal colours,
       " so these are not concealed by default
    if exists("mercury_conceal_logical") && mercury_conceal_logical
      syn match mercuryImplication "=>"   conceal cchar=⇒
      syn match mercuryImplication "<="   conceal cchar=⇐
      syn match mercuryImplication "<=>"  conceal cchar=⇔
      syn keyword mercuryNumCode  inf     conceal cchar=∞
      syn keyword mercuryLogical  some    conceal cchar=∃
      syn keyword mercuryLogical  all     conceal cchar=∀
      syn match mercuryLogical    "\\+"   conceal cchar=¬
    endif
  endif
endif

  " matching the `double star' after the multiplication operator
syn match mercuryOperator "\v[*]{2}"
  " All valid Mercury comments
syn cluster mercuryComments contains=mercuryComment,mercuryCComment
  " The clusters contain all valid Mercury code. The nesting is done to allow
  " for matching of parens, DCG terms and lists
syn cluster mercuryTerms     contains=mercuryBlock,mercuryList,mercuryString,mercuryDelimiter,
      \ mercuryAtom,mercuryNumCode,mercuryFloat,@mercuryComments,mercuryKeyword,mercuryImplKeyword,
      \ @mercuryFormatting,mercuryMisInAny,mercuryBool,mercuryOperator,
      \ mercurySingleton,mercuryImplication,mercuryInlined,mercuryLogical,mercuryPurity
syn region  mercuryList      matchgroup=mercuryBracket   start='\[' end=']' transparent fold  contains=@mercuryTerms
syn region  mercuryBlock     matchgroup=mercuryBracket   start='(' end=')'  transparent fold  contains=@mercuryTerms,mercuryDCGAction
syn region  mercuryDCGAction matchgroup=mercuryBracket   start='{' end='}'  transparent fold  contains=@mercuryTerms
syn region  mercuryForeignModList matchgroup=mercuryBracket   start='\[' end=']' transparent fold  contained contains=
      \ mercuryForeignMod,mercuryDelimiter,@mercuryComments,@mercuryFormatting,
      \ mercuryString,mercuryOperator,mercuryBlock

if !exists("mercury_no_highlight_foreign") || !mercury_no_highlight_foreign
    " Basic syntax highlighting for foreign code
  syn cluster mercuryForeign contains=mercuryForeignModList,mercuryCInterface,
        \ mercuryKeyword,mercuryOperator,
        \ mercuryAtom,mercuryComment,mercuryDelimiter,mercurySingleton,
        \ @mercuryFormatting,mercuryForeignId

  syn region  mercuryForeignCBlock       matchgroup=mercuryBracket start=/\v\(("C"|c)/rs=s+1 end=')'
        \ transparent fold contained contains=@mercuryForeign,mercuryCCode,mercuryBlock
  syn region  mercuryForeignCSharpBlock  matchgroup=mercuryBracket start=/\v\(("C#"|csharp)/rs=s+1 end=')'
        \ transparent fold contained contains=@mercuryForeign,mercuryCSharpCode,mercuryBlock
  syn region  mercuryForeignJavaBlock    matchgroup=mercuryBracket start=/\v\(("Java"|java)/rs=s+1 end=')'
        \ transparent fold contained contains=@mercuryForeign,mercuryJavaCode,mercuryBlock
  syn region  mercuryForeignILBlock      matchgroup=mercuryBracket start=/\v\(("IL"|il)/rs=s+1 end=')'
        \ transparent fold contained contains=@mercuryForeign,mercuryILCode,mercuryBlock
  syn region  mercuryForeignErlangBlock  matchgroup=mercuryBracket start=/\v\(("Erlang"|erlang)/rs=s+1 end=')'
        \ transparent fold contained contains=@mercuryForeign,mercuryErlangCode,mercuryBlock
  syn cluster mercuryForeignBlock contains=mercuryForeignCBlock,mercuryForeignCSharpBlock,
        \ mercuryForeignJavaBlock,mercuryForeignErlangBlock,mercuryForeignILBlock
  syn match   mercuryPragmaForeign /\v^\s*:-\s+pragma\s+foreign_(code|proc|decl|type|export(_enum)?|enum|import_module)/
        \ transparent nextgroup=@mercuryForeignBlock

    " C-Style syntax as a basis for C,C# and Java
  syn keyword mercuryCLikeKeyword contained if else goto switch case for while
  syn keyword mercuryCLikeKeyword contained do break continue return volatile
  syn keyword mercuryCLikeKeyword contained extern typedef static default
  syn keyword mercuryCLikeType contained void int char long byte unsigned signed
  syn keyword mercuryCLikeType contained struct float double enum
  syn match mercuryCLikeDelimiter ";\|," contained
  syn match mercuryCLikeOperator "\v[-!+=*/><~?:%]" contained
  syn match mercuryCLikeOperator "[-!+=*/><]\?=" contained
  syn match mercuryCLikeOperator "--\|++" contained
  syn match mercuryCLikeOperator "|\{1,2}\|&\{1,2}" contained
  syn match mercuryCLikeBracket  "\[\|]" contained
  syn match mercuryCLikeBracket  "\v[{}()]" contained
  syn match mercuryCLikeCharEsc +\\\\""+ contained
  syn match mercuryCLikeCharEsc /\v\\\\([abfnrtv]|0[0-7]*|[xuU]\x+)/ contained
  syn region mercuryCLikeChar start=+'+ end=+'+ contained contains=mercuryCLikeCharEsc
  syn cluster mercuryCLike contains=mercuryCLikeKeyword,mercuryCLikeType,mercuryCLikeOperator,mercuryCComment,mercuryCLikeChar
  syn cluster mercuryCLike add=mercuryNumCode,mercuryFloat,mercuryCLikeBracket
  syn cluster mercuryCLike add=mercuryCLikeDelimiter,mercuryForeignIface

    " C-Language formatting with Mercury types MR_*
  syn keyword mercuryCType contained const size_t pid_t offset_t union
  syn keyword mercuryCType contained MR_bool MR_Word MR_Integer MR_Unsigned
  syn keyword mercuryCType contained MR_ArrayPtr MR_Float MR_file MercuryFile[Ptr]
  syn keyword mercuryCType contained MR_String MR_ConstString
  syn match mercuryCType "\v<MR_((Pseudo)?TypeInfo|TypeCtor(Desc|Info)|AllocSiteInfoPtr)|MercuryLock>" contained
  syn match mercuryCType "\v<(MR_)?[u]?int(_least|_fast)?(8|16|32|64)_t>" contained
  syn match mercuryForeignIface "\v<(MR_)?[U]?INT(_LEAST|_FAST)?(8|16|32|64)_(TYPE|LENGTH_MODIFIER)>" contained
  syn keyword mercuryCKeyword contained typedef sizeof typeof offsetof
  syn keyword mercuryCConst contained NULL EOF
  syn keyword mercuryCConst contained CHAR_BIT CHAR_MAX CHAR_MIN
  syn keyword mercuryCConst contained SCHAR_BIT SCHAR_MAX SCHAR_MIN
  syn keyword mercuryCConst contained LONG_MAX ULONG_MAX LONG_MIN
  syn keyword mercuryCConst contained LLONG_MAX ULLONG_MAX LLONG_MIN
  syn keyword mercuryCConst contained INT_MAX UINT_MAX INT_MIN
  syn keyword mercuryCConst contained SHRT_MAX USHRT_MAX SHRT_MIN
  syn keyword mercuryCBool  contained MR_TRUE MR_FALSE
  syn match mercuryForeignIface "\v<MR_[A-Z]+_LENGTH_MODIFIER>" contained
  syn match mercuryCFunc "\v<MR_(list_(empty|head|tail)|incr_hp((_atomic)?|((_type)?_msg))|assert|fatal_error|make_aligned_string)>" contained
  syn match mercuryCPreProc "#\(if\(n\?def\)\?\|else\|elif\|endif\|define\|include\|error\|warning\|line\)" contained
  syn match mercuryCPreProc    "\v(\\){1,2}$" contained
  syn match mercuryCStringFmt  /%[I]\?[-+# *.0-9]*[dioxXucsfeEgGp]/ contained
  syn region mercuryCString start=+""+ end=+""+ contained contains=mercuryCStringFmt,mercuryCLikeCharEsc
  syn cluster mercuryC contains=@mercuryCLike,mercuryCType,mercuryCKeyword
  syn cluster mercuryC add=mercuryCPreProc,mercuryCString,mercuryCBool,mercuryCConst,mercuryCFunc

    " C++-Style for Java and C# (bool, // comments, exception handling etc)
  syn keyword mercuryCppLikeKeyword contained class new delete try catch finally instanceof abstract
        \ throw[s] extends this super base synchronize[d] override foreach in using import ref
  syn keyword mercuryCppLikeBool contained true false
  syn keyword mercuryCppLikeConst contained null[ptr]
  syn match mercuryCppLikeOperator "@" contained
  syn match mercuryCppLikeType "\v<((io|runtime)\.(\_\s+)?)?(MR_)[A-Za-z_0-9]+>" contained
  syn keyword mercuryCppLikeMod contained public private protected internal virtual
  syn keyword mercuryCppLikeMod contained final readonly volatile transient
  syn cluster mercuryCppLike contains=@mercuryCLike,mercuryCPreProc,mercuryCString,mercuryCppLikeComment,mercuryCppLikeKeyword
  syn cluster mercuryCppLike add=mercuryCppLikeBool,mercuryCppLikeMod,mercuryCppLikeConst,mercuryCppLikeType,mercuryCppLikeOperator

    " Declaration for ISO C
  syn region mercuryCCode      matchgroup=mercuryString start=+"+ skip=+""+ end=+"+ transparent fold contained contains=@mercuryC

   " Declaration for C#
  syn match mercuryCSharpStringFmt "{[0-9]}" contained
  syn match mercuryCSharpStringFmtEsc "{{\|}}" contained
  syn keyword mercuryCSharpType contained object string decimal bool uint
  syn keyword mercuryCSharpType contained ulong sbyte ushort
  syn match mercuryCSharpType contained "\v<mr_bool>\."he=e-1 nextgroup=mercuryCSharpBool
  syn match mercuryCSharpBool contained "\v<(YES|NO)>"
  syn match mercuryCSharpType "\v<System\.((IO|Text|Diagnostics)\.)?[A-Z][A-Za-z_0-9]+>"
  syn region mercuryCSharpString start=+""+ end=+""+ contained contains=mercuryCLikeCharEsc,mercuryCSharpStringFmt,
        \ mercuryCSharpStringFmtEsc
  syn cluster mercuryCSharp contains=@mercuryCppLike,mercuryCSharpString,mercuryCSharpType
  syn region mercuryCSharpCode matchgroup=mercuryString start=+"+ skip=+""+ end=+"+ transparent fold contained
        \ contains=@mercuryCSharp

    " Declaration for Java
  syn match mercuryJavaType "\v([a-z_0-9]+\.(\_\s+)?)+[A-Z][A-Z_a-z0-9]+" contained
  syn match mercuryJavaType "\v<(String(Builder)?|Override|Object|Integer|Byte|Short|Float|Double|Void|Boolean|Character|System|Runtime|boolean)>" contained
  syn match mercuryJavaType "\v<bool>\."he=e-1 contained nextgroup=mercuryJavaBool
  syn match mercuryJavaBool contained "\v<(YES|NO)>"
  syn region mercuryJavaCode   matchgroup=mercuryString start=+"+ skip=+""+ end=+"+
        \ transparent fold contained contains=@mercuryCppLike,mercuryCString,mercuryJavaType

    " Declaration for .NET IL
  syn match mercuryILType "\v<[u]?int(8|16|32|64)|float(32|64)>" contained
  syn cluster mercuryIL contains=@mercuryCSharp,mercuryILType
  syn region mercuryILCode matchgroup=mercuryString start=+"+ skip=+""+ end=+"+ transparent fold contained contains=@mercuryIL

    " Declaration for Erlang
  syn keyword mercuryErlangKeyword contained after and andalso band begin bnot bor bsl bsr bxor case
        \ catch cond end fun if let not of orelse query receive throw try when xor
  syn keyword mercuryErlangBool true false
  syn match mercuryErlangExtNumLiteral "\v([2-9]|[12][0-9]|3[0-6])#[A-Za-z0-9]+" contained
  syn match mercuryErlangOperator "\v[?]" contained
  syn match mercuryErlangLogical "\v[,;.]" contained
  syn region mercuryErlangString start=+""+ end=+""+ contained
  syn cluster mercuryErlangTerms contains=mercuryErlangBlock,mercuryErlangList,mercuryErlangString,
        \ mercuryCLikeChar,mercuryNumCode,mercuryErlangExtNumLiteral,mercuryFloat,mercuryComment,mercuryKeyword,
        \ mercuryErlangKeyword, mercuryErlangOperator, mercuryCComment,mercuryErlangBool,
        \ mercuryOperator,mercurySingleton,mercuryImplication,
        \ mercuryErlangDCGAction,mercuryErlangLogical
  syn region  mercuryErlangList contained matchgroup=mercuryBracket
        \ start='\[' end=']' transparent fold  contains=@mercuryErlangTerms
  syn region  mercuryErlangBlock    contained matchgroup=mercuryBracket
        \ start='(' end=')'  transparent fold  contains=@mercuryErlangTerms
  syn region  mercuryErlangDCGAction contained matchgroup=mercuryBracket
        \ start='{' end='}'  transparent fold  contains=@mercuryErlangTerms
  syn cluster mercuryErlang    contains=@mercuryErlangTerms,mercuryErlangDCGAction,mercuryForeignIface
  syn region mercuryErlangCode   matchgroup=mercuryString start=+"+ skip=+""+ end=+"+
        \ transparent fold contained contains=@mercuryErlang

    " Matching the foreign language name identifiers, this comes after all the
    " code blocks, to match the identifiers in quotes
  syn match mercuryForeignId /\v<(c|csharp|java|il|erlang)>/ contained
  syn region mercuryForeignId contained matchgroup=mercuryString
        \ start=+\v["](C#|Java|C|I[Ll]|Erlang)["]{-}+rs=s+1 end=+"+

    " Matching foreign interface builtins and success indicator
  syn keyword mercuryForeignIface contained SUCCESS_INDICATOR
  syn match mercuryForeignIface "\v<builtin.[A-Z][A-Z_0-9]+>" contained
  syn match mercuryForeignIface "\v<MR_(VERSION|FULLARCH|CYGWIN|WIN32|MINGW64|COMPARE_(LESS|EQUAL|GREATER)|ALLOC_ID)>" contained
endif

if !exists("mercury_no_highlight_trailing_whitespace") || !mercury_no_highlight_trailing_whitespace
  syn match mercuryWhitespace "\v\.?[ \t]+[\n]@="
  syn cluster mercuryFormatting add=mercuryWhitespace
endif

  " Comment handling
syn match mercuryCCommentPrefix "\v^\s*[*]{1,2}(\s+|$)" contained
syn match mercuryCommentInfo contained "\v ((Main |Original )?[Aa]uthor[s]?|File|Created on|Date|Source):"
syn match mercuryCommentInfo " Stability: " contained nextgroup=@mercuryStability
syn match mercuryCopyrightYear "\v (19|20)[0-9][0-9]([, -]+(19|20)[0-9][0-9])*" contained
if has("conceal") && (!exists("mercury_no_conceal") || !mercury_no_conceal)
  syn match mercuryCopyrightSymbol "\v\([cC]\)|©" conceal cchar=© contained nextgroup=mercuryCopyrightYear
else
  syn match mercuryCopyrightSymbol "\v\([cC]\)|©" contained nextgroup=mercuryCopyrightYear
endif
syn match mercuryCommentInfo "\v Copyright " contained nextgroup=mercuryCopyrightSymbol
syn cluster mercuryCommentDirectives contains=mercuryToDo,mercuryCommentInfo,@mercuryCommentTex
syn keyword mercuryStabilityLow    contained low    nextgroup=mercuryStabilityTo
syn keyword mercuryStabilityMedium contained medium nextgroup=mercuryStabilityTo
syn keyword mercuryStabilityHigh   contained high
syn match mercuryStabilityTo "\v-| to " contained nextgroup=@mercuryStability
syn cluster mercuryStability contains=mercuryStabilityLow,mercuryStabilityMedium,mercuryStabilityHigh

syn match mercuryCommentTexDblQuote +``\|''+ contained
syn cluster mercuryCommentTex contains=mercuryCommentTexDblQuote

if exists("mercury_highlight_full_comment") && mercury_highlight_full_comment
  syn region  mercuryComment start="%" end=/\v(\S|\s+\S)*$?/ oneline
        \ contains=@mercuryCommentDirectives,@mercuryFormatting
  syn region  mercuryCComment       matchgroup=mercuryComment start="/\*" end="\*/"
        \ fold  contains=@mercuryCommentDirectives,mercuryCCommentPrefix,@mercuryFormatting
  syn region  mercuryCppLikeComment matchgroup=mercuryComment start="//"  end=/\v(\S|\s+\S)*$?/
        \ oneline  contained contains=@mercuryCommentDirectives,@mercuryFormatting
else
  syn region  mercuryComment start=+%[-=%*_]*+ matchgroup=NONE end=/\v(\S|\s+\S)*$?/he=s-1
        \ oneline contains=@mercuryCommentDirectives,@mercuryFormatting
  syn region  mercuryCComment matchgroup=mercuryComment start="\v/\*([-*]+$){0,1}" end="[-*]*\*/"
        \ transparent fold  contains=@mercuryCommentDirectives,mercuryCCommentPrefix,@mercuryFormatting
  syn region  mercuryCppLikeComment matchgroup=mercuryComment start="//" matchgroup=NONE end=/\v(\S|\s+\S)*$?/
        \ transparent oneline contained
        \ contains=@mercuryCommentDirectives,@mercuryFormatting
endif

  " Matching the output of the error command in extras
syn region  mercuryCComment  matchgroup=mercuryError start="/\* ###" end="\v[^*]+\*/" oneline

  " Matching Vim modeline
syn match mercuryModelineParam "\v(sw|ts|tw|wm|ff|ft)\=" contained
syn match mercuryModelineParam "\vet|expandtab" contained
syn match mercuryModelineValue "\<\(mercury\|unix\)\>" contained
syn region mercuryModeline matchgroup=mercuryComment  start="% vim:" end=+$+
      \ oneline contains=mercuryModelineParam,mercuryModelineValue,mercuryNumCode
syn region mercuryShebang matchgroup=mercuryComment  start="^\%1l#!/" end=/\v.+$/     oneline

  " Matching overlong lines
if !exists("mercury_no_highlight_overlong") || !mercury_no_highlight_overlong
  syn match mercuryTooLong /\%80v[^")}\]%]*/
  syn cluster mercuryFormatting add=mercuryTooLong
endif

   " XXX: syn sync fromstart is the safest operation, which can cover
   " arbitrary large string literals, but it is also the slowest option for
   " huge source files, e.g. library/io.m.
   " One could use a comment line for synchronization
   " using "syn sync match"-magic
syn sync clear
syn sync fromstart

hi def link mercuryAccess           Identifier
hi def link mercurySingleton        Identifier
hi def link mercuryAtom             Constant
hi def link mercuryBracket          mercuryDelimiter
hi def link mercuryBool             Special
hi def link mercuryComment          Comment
hi def link mercuryCommentInfo      Identifier
hi def link mercuryCommentTexDblQuote  Special
hi def link mercuryCopyrightSymbol  Operator
hi def link mercuryCopyrightYear    Constant
hi def link mercuryCComment         mercuryComment
hi def link mercuryCCommentPrefix   mercuryComment
hi def link mercuryCInterface       mercuryPragma
if !exists("mercury_no_highlight_foreign") || !mercury_no_highlight_foreign
  hi def link mercuryForeignId        Identifier
  hi def link mercuryCLikeBracket     mercuryBracket
  hi def link mercuryCLikeOperator    mercuryOperator
  hi def link mercuryCLikeChar        mercuryAtom
  hi def link mercuryCLikeCharEsc     mercuryStringEsc
  hi def link mercuryCLikeDelimiter   mercuryDelimiter
  hi def link mercuryCLikeKeyword     Keyword
  hi def link mercuryCLikeString      mercuryString
  hi def link mercuryCppLikeType      Type
  hi def link mercuryCLikeType        Type
  hi def link mercuryCBool            mercuryBool
  hi def link mercuryCConst           Constant
  hi def link mercuryCFunc            Identifier
  hi def link mercuryCKeyword         Keyword
  hi def link mercuryCStringFmt       mercuryStringFmt
  hi def link mercuryCType            Type
  hi def link mercuryCPreProc         mercuryPragma
  hi def link mercuryCppLikeBool      mercuryBool
  hi def link mercuryCppLikeConst     Constant
  hi def link mercuryCppLikeKeyword   Keyword
  hi def link mercuryCppLikeMod       mercuryAccess
  hi def link mercuryCppLikeOperator  mercuryOperator
  hi def link mercuryCString          mercuryString
  hi def link mercuryCSharpBool       mercuryBool
  hi def link mercuryCSharpString     mercuryString
  hi def link mercuryCSharpStringFmt  mercuryStringFmt
  hi def link mercuryCSharpStringFmtEsc Identifier
  hi def link mercuryCSharpType       Type
  hi def link mercuryJavaBool         mercuryBool
  hi def link mercuryJavaType         Type
  hi def link mercuryILType           Type
  hi def link mercuryErlangKeyword    Keyword
  hi def link mercuryErlangOperator   Operator
  hi def link mercuryErlangBool       mercuryBool
  hi def link mercuryErlangExtNumLiteral Number
  hi def link mercuryErlangString     mercuryString
  hi def link mercuryErlangLogical    mercuryLogical
endif
hi def link mercuryDelimiter        Delimiter
hi def link mercuryError            ErrorMsg
hi def link mercuryPurity           Special
hi def link mercuryImplKeyword      Identifier
hi def link mercuryKeyword          Keyword
hi def link mercuryModelineParam    Identifier
hi def link mercuryModelineValue    Constant
hi def link mercuryNumCode          Number
hi def link mercuryFloat            Float
hi def link mercuryPragma           PreProc
hi def link mercuryForeignMod       mercuryForeignIface
hi def link mercuryForeignOperator  mercuryOperator
hi def link mercuryForeignIface     Identifier
hi def link mercuryImplication      Special
hi def link mercuryLogical          Special
hi def link mercuryEscErr           ErrorMsg
hi def link mercuryMisInAny         ErrorMsg
hi def link mercuryOperator         Operator
hi def link mercuryInlined          Operator
hi mercuryStabilityLow     ctermfg=red        guifg=red
hi mercuryStabilityMedium  ctermfg=darkyellow guifg=darkyellow
hi mercuryStabilityHigh    ctermfg=darkgreen  guifg=darkgreen
hi def link mercuryStabilityTo      Delimiter
hi def link mercuryString           String
hi def link mercuryStringEsc        Identifier
hi def link mercuryStringFmt        Special
hi def link mercuryToDo             Todo
hi def link mercuryTooLong          mercuryError
hi def link mercuryWhitespace       mercuryTodo
hi def link mercuryTerminator       Delimiter
hi def link mercuryType             Type
