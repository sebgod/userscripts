" vim: ft=vim ts=2 sw=2 et

au! BufNewFile,BufRead *.il
    \ if (getline(2) =~ 'Microsoft') || (getline(2) =~ 'Melbourne') |
    \   setf ilasm |
    \ endif
