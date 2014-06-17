" vim: ft=vim tw=2 sw=2 et
" Language:	Modula 2
" Maintainer:	Sebastian Godelet <sebastian.godelet+github@gmail.com>
" Extension:	*.mod *.def
" Last Change:	2014-07-14
"

if version < 600
  " Remove any old syntax stuff hanging around
  syn clear
elseif exists("b:current_syntax") && b:current_syntax =~ "modula2ex"
  finish
endif

if !exists("foldminlines")
  set foldminlines=10
endif

" syn case match " case sensitiv match is default
syn case match

" A bunch of keywords
syn keyword modula2Keyword ACTID ALL AND AS ASK
syn keyword modula2Keyword BY CALL CASE CLASS CONST DIV
syn keyword modula2Keyword DOWNTO DO DURATION ELSE ELSIF EXIT EXCEPT
syn keyword modula2Keyword FINALLY FIXED FOR
syn keyword modula2Keyword FOREACH FORWARD IF THEN IN INHERITED INOUT
syn keyword modula2Keyword INTERRUPT LOOP
syn keyword modula2Keyword MOD MONITOR NEWVALUE
syn keyword modula2Keyword NONMODSIM NOT OBJECT OF ON OR ORIGINAL OTHERWISE OUT
syn keyword modula2Keyword OVERRIDE PRIVATE PROTO REPEAT
syn keyword modula2Keyword RECORD RETURN REVERSED SELF STRERR TELL
syn keyword modula2Keyword TERMINATE THISMETHOD TO TYPE UNTIL VALUE VAR
syn keyword modula2Keyword WAIT WAITFOR WHEN WHILE WITH

" Builtin functions and procedures
syn keyword modula2Builtin ABS DIFADR ADR ADDADR ACTIVATE ADDMONITOR CAP CAST CHARTOSTR CHR CLONE
syn keyword modula2Builtin DEACTIVATE DEC DISPOSE FLOAT GETMONITOR HIGH INC
syn keyword modula2Builtin INPUT INSERT INTTOSTR ISANCESTOR LOW LOWER MAX MAXOF
syn keyword modula2Builtin MIN MINOF NEW OBJTYPEID OBJTYPENAME OBJVARID ODD
syn keyword modula2Builtin ONERROR ONEXIT ORD OUTPUT POSITION PRINT REALTOSTR
syn keyword modula2Builtin REPLACE REMOVEMONITOR ROUND SCHAR SIZEOF SPRINT
syn keyword modula2Builtin STRLEN STRTOCHAR STRTOINT STRTOREAL SUBSTR TRUNC
syn keyword modula2Builtin UPDATEVALUE UPPER VAL

syn keyword modula2BuiltinNoParen HALT TRACE SIZE

" Special keywords
syn keyword modula2Block PROCEDURE METHOD MODULE MAIN DEFINITION IMPLEMENTATION
syn keyword modula2Block BEGIN END

syn keyword modula2Bool TRUE FALSE NIL

syn keyword modula2Include IMPORT FROM

syn keyword modula2Type ADDRESS ANYARRAY ANYOBJ ANYREC ARRAY BOOLEAN CHAR WCHAR
syn keyword modula2Type BITSET8 BITSET16 BITSET32 BITSET BYTE
syn keyword modula2Type CARDINAL CARD8 CARD16 CARD32 CARD64 INT8 INT16 INT32 INTEGER
syn keyword modula2Type LMONITORED LRMONITORED NILARRAY NILOBJ NILREC REAL LONGREAL
syn keyword modula2Type RMONITOR RMONITORED STRING POINTER SET TSIZE

" catch errros cause by wrong parenthesis
" slight problem with "( *)" or "(* )". Hints?
syn region modula2Paren matchgroup=modula2Delim transparent start='(' end=')' contains=ALLBUT,modula2ParenError
syn match modula2ParenError ")"

" Numbers
syn match modula2Number "\v<\d+>"

" Comments
syn region modula2Comment1 transparent matchgroup=modula2Delim start="{" end="}" contains=modula2Comment1,
  \ modula2Comment2,modula2Number,modula2Keyword,modula2CharCode,modula2Delim,modula2String,modula2Literal
syn region modula2Comment2 matchgroup=modula2Comment transparent start="(\*" end="\*)" contains=modula2Comment1,modula2Comment2
syn region modula2Comment3 start="<\*" end="\*>" contains=modula2Directive,
  \ modula2Operator,modula2Warning,modula2String,modula2Literal,modula2Number

syn keyword modula2Directive contained IF PUSH POP THEN END ELSE
syn match modula2Directive contained "M2EXTENSIONS"
syn match modula2Directive contained "[+-]"
syn match modula2Warning contained "\vW(ON|OFF)\d+"
" highlighting is wrong for constructs like "{  (*  }  *)",
" which are allowed in Modsim III, but
" I think something like that shouldn't be used anyway.

" Delimiters
syn match modula2Delim "[,;:.]"

" Operators
syn match modula2Operator "=" 
syn match modula2Operator ":=" 
syn match modula2Operator "+" 
syn match modula2Operator "/" 
syn match modula2Operator "*" 
syn match modula2Operator "<" 
syn match modula2Operator "<=" 
syn match modula2Operator ">" 
syn match modula2Operator ">=" 
syn match modula2Operator "<>" 
syn match modula2Operator "-" 
syn match modula2Operator "|" 
syn match modula2Operator "\^" 

" Array indexer
syn region modula2Array matchgroup=modula2Delim transparent start="\[" end="\]" contains=modula2Range,
  \ modula2Number,modula2Builtin,modula2BuiltinNoParen,modula2Type
syn match modula2ArrayRange contained "\.\." 

" Strings
syn region modula2String start=+"+ end=+"+

" Literals
"syn region modula2Literal start=+'+ end=+'+
syn match modula2Literal "'[^']'\|''''"
syn match modula2CharCode "\v\d+C"

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_modula2_syntax_inits")
  if version < 508
    let did_modula2_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  " The default methods for highlighting.  Can be overridden later
  HiLink modula2Delim           Delimiter
  HiLink modula2ParenError	Error
  HiLink modula2Keyword         Statement
  HiLink modula2Bool            Identifier
  HiLink modula2Block           Statement
  HiLink modula2Comment         Comment
  HiLink modula2Comment3        Comment
  HiLink modula2Operator        Operator
  HiLink modula2Directive       Special
  HiLink modula2Number          Constant
  HiLink modula2String	        String
  HiLink modula2CharCode        Character
  HiLink modula2Literal	        Character
  HiLink modula2Include	        Statement
  HiLink modula2Type	        Type
  HiLink modula2Builtin         Function
  HiLink modula2BuiltinNoParen	Function
  HiLink modula2Warning         ToDo

  delcommand HiLink
endif

syn sync fromstart
let b:current_syntax = "modula2ex"

" vim: ts=8 sw=2

