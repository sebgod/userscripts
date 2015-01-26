" mercury-package.vim
" vim: ts=2 sw=2 et

au! BufNewFile,BufRead *.package
    \ if getline(1) =~ '\v[a-z]+[(][^)]+[)][.]' |
    \   setf mercury |
    \ endif
