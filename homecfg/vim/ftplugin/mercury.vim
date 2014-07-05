" Vim syntax file
" Language:     Mercury
" Maintainer:   Ralph Becket <rafe@cs.mu.oz.au>
" vim: ts=2 sw=2 et

if exists("b:did_mercury_ftplugin")
  finish
endif
let b:did_mercury_ftplugin = 1

  " Miscellaneous settings.

  " I find it handy to run `mtags' over the Mercury library .m files
  " and move the resulting tags file to `$HOME/mercury/tags.library'.
  "
setlocal tags+=$HOME/dev/mercury/tags.library,$HOME/dev/mercury/tags.compiler

  " Handy if you use `:make'.
  "
setlocal makeprg="mmc -m"

  " Don't wrap over-long lines.
  "
setlocal wrapmargin=0
setlocal textwidth=0

  " These settings allow for neater coding styles, but
  " should not be imposed on existing files that use,
  " say, the default `tabstop=8, shiftwidth=8, noexpandtab'.
  "
  " It is a good idea to have a modeline comment at the top
  " of your Mercury source files containing
  " ` vim: ft=mercury ff=unix ts=4 sw=4 et '
  "
" setlocal tabstop=8
" setlocal shiftwidth=8
" setlocal expandtab   

  " Controls how autoindenting works.  See the Vim help pages for details.
  "
setlocal formatoptions=trcq

  " <C-X>l inserts a comment line.
  "
nnoremap <C-X>l o0<C-D>%----------------------------------------------------------------------------%<CR><ESC>x
inoremap <C-X>l ------------------------------------------------------------------------------<ESC>80<BAR>C%<CR>

  " <F6> attempts to wrap a call up with { } braces for DCG escapes.
  "
nnoremap <F6> I{ <ESC>%a }<ESC>j

  " <F7> and <F8> comment and uncomment lines out respectively.
  "
nnoremap <F7> 0i% <ESC>j
nnoremap <F8> :s/% //e<CR>j

  " <F9> visually selects the current code block (e.g. predicate defintion,
  " declaration, pragma, bascially everything from (:-|^atom) to terminal .
  "
nnoremap <F9> :call MercuryMarkCurrentPred()<CR>

  " <F10> is for renaming variables
  "
nnoremap <F10> :call MercuryRenameVariable()<CR>

  " <C-X>h runs `$HOME/.vim/ftplugin/mercuryhdr.sh' which inserts all the
  " usual boilerplate for a new Mercury module.
  "
nnoremap <C-X>h !!$HOME/.vim/ftplugin/mercuryhdr.sh %<CR>:set ft=mercury ff=unix ts=4 sw=4 et<CR>

  " Go to the bottom window and rerun the last mmake command.
  " Reload any .err buffers that have changed.
  "
nnoremap ,m <C-W>b:!mmake<UP><CR>
autocmd! FileChangedShell *.err vi!

  " Match all the occurances of the variable under the cursor
  "
augroup mercuryMatchVar
  autocmd! CursorMoved,CursorMovedI,WinEnter <buffer> call s:Highlight_Matching_Variables()
augroup END

fu! s:Highlight_Matching_Variables()
    " Avoid that we remove the popup menu.
    " Return when there are no colors (looks like the cursor jumps).
  if pumvisible() || (&t_Co < 8 && !has("gui_running"))
    return
  endif

    " Get variable under cursor, or "" if empty
  let l:variable = s:GetCurrentCursorVariable()

  let l:lineL1PredStart = search("^[:a-z']", 'nWb')
  let l:posEnd = searchpos('\v[.]($|\s+)', 'nW')

  while s:CurrentSynIsTransparent(l:posEnd) > 0
    let l:posEnd = searchpos('\v[.]($|\s+)%>' . l:posEnd[0] . 'l', 'nW')
  endwhile

  let l:lineL1PredEnd = l:posEnd[0]
  if l:lineL1PredStart <= 0|let l:lineL1PredStart = line('w0')|endif
  if l:lineL1PredEnd   <= 0|let l:lineL1PredEnd   = line('w$')|endif

    " If we are still on the same spot, then abort
  if exists('w:variable') && l:variable == w:variable &&
        \ l:lineL1PredStart == w:lineL1PredStart &&
        \ l:lineL1PredEnd   == w:lineL1PredEnd
    return
  elseif exists('w:variable_hl_on') && w:variable_hl_on
    " Remove any previous match.
    2match none
    let w:variable_hl_on = 0
  endif

  let w:variable        = l:variable
  let w:lineL1PredStart = l:lineL1PredStart
  let w:lineL1PredEnd   = l:lineL1PredEnd
  let w:lineL1PredEndCol = l:posEnd[1]

    " Abort if there is no variable under the cursor
  if l:variable == ""|return|endif

    " Underline all Variable occurances in the current (outer)
    " predicate/function/pragma scope
  let l:variableMatch = s:CreateVariableMatch(l:variable,
        \ l:lineL1PredStart, l:lineL1PredEnd)
  exe '2match Underlined ' . l:variableMatch
  let w:variable_hl_on = 1
endfu

fu! s:CreateVariableMatch(variable, start, end)
  return '/\v<' . escape(a:variable, '\') . '>' .
        \ '%>' . (a:start - 1) . 'l' .
        \ '%<' . (a:end   + 1) . 'l' . '/'
endfu

fu! s:CurrentSynIsTransparent(pos)
  if a:pos[0] == 0|return 0|endif
  let l:id = synID(a:pos[0], a:pos[1], 0)
  return l:id == synIDtrans(l:id) ? 1 : 0
endfu

fu! s:GetCurrentCursorVariable()
    " returns the variable under the cursor
  let l:word = expand("<cword>")
  if empty(matchstr(l:word, '\v^[A-Z]'))
    return ""
  else
    return l:word
  endif
endfu

fu! MercuryRenameVariable()
  if !empty(w:variable)
    call inputsave()
    let l:new = input('Enter a new variable name: ', w:variable)
    call inputrestore()
      " Allow for a silent return if the input is empty (most likely it means
      " the user pressed ESC
    if empty(l:new)|return|endif
      " using the predicate range as a boundary for a global %s
    let l:variableMatch = s:CreateVariableMatch(w:variable,
          \ w:lineL1PredStart, w:lineL1PredEnd)
    exe '%s' . l:variableMatch . escape(l:new, '\') . '/g'
  else
    echoerr 'Nothing selected to be renamed!'
  endif
endfu

fu! MercuryMarkCurrentPred()
  call setpos('.', [0, w:lineL1PredStart, 1])
  normal! v
  call setpos('.', [1, w:lineL1PredEnd, w:lineL1PredEndCol])
endfu
