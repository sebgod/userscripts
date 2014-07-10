" vim: ft=vim ts=2 sw=2 et

au! BufNewFile,BufRead *.il
    \ if getline(2) =~ 'Microsoft' |
    \   setf ilasm |
    \ endif
