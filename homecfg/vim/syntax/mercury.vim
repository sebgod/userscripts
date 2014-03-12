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

syn cluster mercuryCommentDirectives contains=mercuryToDo,mercuryModeline
if exists("mercury_highlight_full_comment") && mercury_highlight_full_comment
  syn region  mercuryComment                               start=+%+ end=+.*$+            oneline  contains=@mercuryCommentDirectives
  syn region  mercuryCComment matchgroup=mercuryComment    start=+/\*+ end=+\*/+             fold  contains=@mercuryCommentDirectives
else
  syn region  mercuryComment                            start=+%[-=%*_]*+ end=+.*$+he=s-1 oneline  contains=@mercuryCommentDirectives
  syn region  mercuryCComment matchgroup=mercuryComment start=+/\*+ end=+\*/+    transparent fold  contains=@mercuryCommentDirectives
endif
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
syn keyword mercuryKeyword      trace atomic or_else
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
syn keyword mercuryCInterface   may_call_mercury will_not_call_mercury
syn keyword mercuryCInterface   thread_safe not_thread_safe maybe_thread_safe
syn keyword mercuryCInterface   promise_pure promise_semipure
syn keyword mercuryCInterface   tabled_for_io local untrailed trailed 
syn keyword mercuryCInterface   attach_to_io_state 
syn keyword mercuryCInterface   can_pass_as_mercury_type stable
syn keyword mercuryCInterface   will_not_throw_exception
syn keyword mercuryCInterface   may_modify_trail will_not_modify_trail
syn keyword mercuryCInterface   may_duplicate may_not_duplicate
syn keyword mercuryCInterface   affects_liveness
syn keyword mercuryCInterface   does_not_affect_liveness doesnt_affect_liveness
syn keyword mercuryCInterface   no_sharing unknown_sharing sharing
syn keyword mercuryImpure       impure semipure
syn keyword mercuryToDo         XXX TODO NOTE         
syn keyword mercuryBool         true false
syn keyword mercuryLogical      some all not if then else fail or and
syn keyword mercuryLogical      try catch catch_any
syn keyword mercuryLogical      semidet_true semidet_false semidet_fail
syn keyword mercuryLogical      impure_true
syn match   mercuryLogical      "\\+"
syn match   mercuryImplication  +<=>\|<=\|=>+
syn match   mercuryImplication  "\\/"
syn match   mercuryImplication  "/\\"
syn match   mercuryOperator     "=\.\."
syn match   mercuryOperator     "="
syn match   mercuryOperator     "=:="
syn match   mercuryOperator     "=<"
syn match   mercuryOperator     "=\\="
syn match   mercuryOperator     "@<"
syn match   mercuryOperator     "@=<"
syn match   mercuryOperator     "@>"
syn match   mercuryOperator     "@>="
syn match   mercuryOperator     ">="
syn match   mercuryOperator     ">"
syn match   mercuryOperator     "\\=="
syn match   mercuryOperator     "\\="
syn match   mercuryOperator     "\~="
syn match   mercuryOperator     ":="
syn match   mercuryOperator     ":-"
syn match   mercuryOperator     "![:.]\{0,1}"
  " The first semicolon in the line has the operator colour, matching '(,)'
syn match   mercuryOperator     "\v^\s+;"
  " The inline semicolon the implication colour, matching '->'
syn match   mercuryImplication  ";"
syn match   mercuryOperator     "++"
syn match   mercuryOperator     "+"
syn match   mercuryOperator     "::"
syn match   mercuryOperator     "&"
syn match   mercuryOperator     "--->"
syn match   mercuryOperator     "-->"
syn match   mercuryImplication  "->"
syn match   mercuryOperator     "?-"
syn match   mercuryOperator     "-"
syn match   mercuryOperator     "/"
syn match   mercuryOperator     "*"
syn match   mercuryOperator     "\^"
syn match   mercuryTerminator   "\v\.$"
syn match   mercuryNumCode      +0'.\|0[box][0-9a-fA-F]*+
syn region  mercuryAtom         start=+'+ skip=+\\.+ end=+'+
syn region  mercuryString       start=+"+ skip=+\\.+ end=+"+                                  contains=mercuryStringFmt
syn match   mercuryStringFmt    +""\|\\[abfnrtv\\"]\|\\x[0-9a-fA-F]*\\\|%[-+# *.0-9]*[dioxXucsfeEgGp]+      contained
syn cluster mercuryTerms  contains=mercuryBlock,mercuryList,mercuryString,mercuryAtom,mercuryComment,mercuryCComment,mercuryBool,mercuryOperator,mercuryAnyVar
syn cluster mercuryCode   contains=@mercuryTerms,mercuryKeyword,mercuryLogical,mercuryImplication
syn region  mercuryList      matchgroup=mercuryOperator  start='\[' end=']'    transparent fold  contains=@mercuryTerms
syn region  mercuryBlock     matchgroup=mercuryOperator  start='(' end=')'     transparent fold  contains=@mercuryCode
syn region  mercuryDCGAction matchgroup=mercuryOperator  start='{' end='}'     transparent fold  contains=@mercuryCode
syn region  mercuryInlined   matchgroup=mercuryOperator  start='`' end='`'
if !exists("mercury_no_highlight_overlong") || !mercury_no_highlight_overlong
  " The complicated regexp here matches an 80-column string,
  " with proper treatment of tabs (assuming the tab size is 4):
  " each row consists of 20 columns, and each column consists of either 4
  " non-tab characters, or 0-4 non-tab characters followed by a tab.
  syn match   mercuryFirst80 +^\([^	]\{4}\|[^	]\{0,3}	\)\{20}+                                contains=ALL
  syn match   mercuryTooLong +^\([^	]\{4}\|[^	]\{0,3}	\)\{20}..*+                             contains=mercuryFirst80
endif

  " Matching Vim modeline 
syn match   mercuryModeline  "\vvim:([ :]((sw|ts|tw|wm)\=\d+|et|(ft\=\w+)))+" contained

if !exists("mercury_no_highlight_trailing_whitespace") || !mercury_no_highlight_trailing_whitespace
  syn match mercuryWhitespace "\v\s+$"
endif

if !exists("mercury_allow_tabs") || !mercury_allow_tabs
  syn match mercuryWhitespace "\v\t+"
endif

syn sync fromstart

hi link mercuryComment          Comment
hi link mercuryCComment         Comment
hi link mercuryNumCode          Special
hi link mercuryImpure           Special
hi link mercuryKeyword          Keyword
hi link mercuryPragma           PreProc
hi link mercuryCInterface       PreProc
hi link mercuryToDo             Todo
hi link mercuryBool             Special
hi link mercuryLogical          Special
hi link mercuryImplication      Special
hi link mercuryAnyVar           Special
hi link mercuryOperator         Operator
hi link mercuryInlined          Operator
hi link mercuryString           String
hi link mercuryStringFmt        Special
hi link mercuryAtom             Constant
hi link mercuryTooLong          ErrorMsg
hi link mercuryWhitespace       ErrorMsg
hi link mercuryTerminator       Statement
hi link mercuryModeline         Special
