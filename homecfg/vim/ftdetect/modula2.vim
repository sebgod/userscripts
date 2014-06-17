" vim: ft=vim

au! BufNewFile,BufRead *.mod
    \ if getline(1) =~ 'IMPLEMENTATION' |
    \   setf modula2 |
    \ endif

au! BufNewFile,BufRead *.def
    \ if getline(1) =~ 'DEFINITION' |
    \   setf modula2 |
    \ endif
