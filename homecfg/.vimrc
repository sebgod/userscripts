syntax on
filetype plugin on

if has("multi_byte")
  set encoding=utf-8                     " better default than latin1
  setglobal fileencoding=utf-8           " change default file encoding when writing new files
  if &termencoding == ""
    let &termencoding = &encoding
  endif
endif