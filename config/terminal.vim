" Terminal workflow helpers.

let g:queryvs_terminal_buf = -1

function! s:FocusedDir() abort
  let l:path = expand('%:p')
  if !empty(l:path) && filereadable(l:path)
    let g:queryvs_last_file_dir = fnamemodify(l:path, ':h')
    return g:queryvs_last_file_dir
  endif

  if !empty(l:path) && isdirectory(l:path)
    let g:queryvs_last_file_dir = l:path
    return g:queryvs_last_file_dir
  endif

  return g:queryvs_last_file_dir
endfunction

function! s:OpenTerminalPanel(vertical, use_focused_dir) abort
  let l:term_height = max([8, float2nr(&lines / 3)])
  let l:term_width = max([30, float2nr(&columns / 3)])
  let l:dir = a:use_focused_dir ? s:FocusedDir() : ''

  if a:use_focused_dir
    if a:vertical
      execute 'botright vertical ' . l:term_width . 'split'
    else
      execute 'botright ' . l:term_height . 'split'
    endif
    if !empty(l:dir) && isdirectory(l:dir)
      execute 'lcd ' . fnameescape(l:dir)
    endif
    terminal
    setlocal nobuflisted
    startinsert
    return
  endif

  if bufexists(g:queryvs_terminal_buf)
    let l:wins = win_findbuf(g:queryvs_terminal_buf)
    if !empty(l:wins)
      call win_gotoid(l:wins[0])
      if a:vertical
        execute 'vertical resize ' . l:term_width
      else
        execute 'resize ' . l:term_height
      endif
    elseif a:vertical
      execute 'botright vertical ' . l:term_width . 'split'
      execute 'buffer ' . g:queryvs_terminal_buf
    else
      execute 'botright ' . l:term_height . 'split'
      execute 'buffer ' . g:queryvs_terminal_buf
    endif
  else
    if a:vertical
      execute 'botright vertical ' . l:term_width . 'split'
    else
      execute 'botright ' . l:term_height . 'split'
    endif
    terminal
    let g:queryvs_terminal_buf = bufnr('%')
    setlocal nobuflisted
  endif
  startinsert
endfunction

function! s:OpenTerminalTab() abort
  tabnew
  let t:queryvs_tab_label = 'Terminal'
  terminal
  startinsert
endfunction

command! TerminalPanel call s:OpenTerminalPanel(0, 0)
command! TerminalVPanel call s:OpenTerminalPanel(1, 0)
command! TerminalHere call s:OpenTerminalPanel(0, 1)
command! TerminalVHere call s:OpenTerminalPanel(1, 1)
command! TerminalTab call s:OpenTerminalTab()
