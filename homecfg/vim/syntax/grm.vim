" Vim syntax file
" vim: ft=vim ts=2 sw=2 et
" Language:         GRM (Gold PARSER)
" Maintainer:       Sebastian Godelet <sebastian.godelet+github@gmail.com>
" Last Change:      2014-07-10

" Quit when a syntax file was already loaded  {{{
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif
"}}}

let b:current_syntax = "grm"

"  Syntax rules
"  

" Base data (or terminal nodes)
syn match  grmOr               "|"                 nextgroup=grmDefinition contained
syn match  grmString           +"[^"]*"+           contains=grmParam
syn match  grmString           +'[^']*'+        
syn match  grmOperator         /[+*\/-]/
syn match  grmSetNode          "{[^}]*}"           contained 
syn match  grmTerminalNode     "[A-Z][^ ]*"        contained 
syn match  grmRuleNode         "<[^>]*>"           contained
syn match  grmEnumBlock        "\[[^\[]*\]"        
syn match  grmComment          "!.*$" 

" Parameter statement (Quoted Keyword followed by equal symbol followed by
" user data)
" With special handling for "Start Symbol"
syn match  grmParam            +"[^"]*"+           nextgroup=grmSepEqualParam
syn match  grmSepEqualParam    "\s*=\s*"           nextgroup=grmDefinitionParam contained 
syn match  grmDefinitionParam  /.*$/               contained contains=grmString,grmComment
syn region grmParamStart        start=+"Start Symbol"+ skip=+\s*=\s*+ end=/$/ 

" Terminal and Set statement
syn match  grmSet              /{[A-Z][^}]*}/      nextgroup=grmSepEqual 
syn match  grmTerminal          /[A-Z][^ ]*/       nextgroup=grmSepEqual 
syn match  grmSepEqual          "\s*=\s*"          nextgroup=grmDefinition contained 


" Rule statement
syn match  grmRule              /<[^>$]*>/         nextgroup=grmSepInstr 
syn match  grmSepInstr          "\s*::=\s*"        nextgroup=grmDefinition contained 

" Partial definition 
syn match  grmPartDef          /^\s*|/             contains=grmOr nextgroup=grmDefinition

" definition of rules, sets and terminals
syn match  grmDefinition        /.*$/              contained contains=grmEnumBlock,grmSetNode,grmTerminalNode,grmRuleNode,grmString,grmOr,grmOperator,grmComment,grmConst


"  Color definition
"  
hi def link grmConst            Constant
hi def link grmRule             Statement
hi def link grmTerminal         Type
hi def link grmSet              Special 
hi def link grmSetNode          Special
hi def link grmParam            PreProc
hi def link grmParamStart       Statement
hi def link grmString           String
hi def link grmOperator         ctermfg=1 guifg=red
hi def link grmComment          Comment
hi def link grmOr               ctermfg=1 gui=bold guifg=red
hi def link grmRuleNode         Identifier
hi def link grmTerminalNode     Type
hi def link grmEnumBlock        Constant
hi grmDefinitionParam  gui=italic guifg=blue
