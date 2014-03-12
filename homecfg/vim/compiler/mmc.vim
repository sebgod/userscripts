" Vim compiler file
" Compiler: 	Mercury
" Maintainer: 	Sebastian Godelet <sebastian.godelet at gmail dot com>
" Last Change: 	2014-01-27

if exists("current_compiler")
   finish
endif
let current_compielr = "mmc"

CompilerSet makeprg=mmc\ --make\ %

CompilerSet errorformat=%f:%l:\ %m
