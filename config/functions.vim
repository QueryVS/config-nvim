" Shared Vimscript helpers.

let g:queryvs_last_file_dir = getcwd()
let g:queryvs_last_file_win = -1

function! s:IsFileWindow(winid) abort
  if !win_id2win(a:winid)
    return 0
  endif

  let l:buf = winbufnr(a:winid)
  let l:bt = getbufvar(l:buf, '&buftype')
  let l:ft = getbufvar(l:buf, '&filetype')
  return l:bt ==# '' && l:ft !=# 'neo-tree'
endfunction

function! QueryVSRememberFileWindow() abort
  if s:IsFileWindow(win_getid())
    let g:queryvs_last_file_win = win_getid()
  endif
endfunction

function! s:GoToFileWindowForBufferSwitch() abort
  if s:IsFileWindow(win_getid())
    let g:queryvs_last_file_win = win_getid()
    return
  endif

  if s:IsFileWindow(g:queryvs_last_file_win)
    call win_gotoid(g:queryvs_last_file_win)
    return
  endif

  for l:win in range(1, winnr('$'))
    let l:winid = win_getid(l:win)
    if s:IsFileWindow(l:winid)
      call win_gotoid(l:winid)
      let g:queryvs_last_file_win = l:winid
      return
    endif
  endfor
endfunction

function! s:IsFileBuffer(bufnr) abort
  return buflisted(a:bufnr) && getbufvar(a:bufnr, '&buftype') ==# ''
endfunction

function! s:CurrentFileBuffer() abort
  if s:IsFileWindow(win_getid())
    return bufnr('%')
  endif

  if s:IsFileWindow(g:queryvs_last_file_win)
    return winbufnr(g:queryvs_last_file_win)
  endif

  for l:win in range(1, winnr('$'))
    let l:winid = win_getid(l:win)
    if s:IsFileWindow(l:winid)
      return winbufnr(l:winid)
    endif
  endfor

  return bufnr('%')
endfunction

function! s:TargetFileBuffer(direction) abort
  let l:buffers = filter(range(1, bufnr('$')), 's:IsFileBuffer(v:val)')
  if empty(l:buffers)
    return -1
  endif

  let l:current = s:CurrentFileBuffer()
  let l:index = index(l:buffers, l:current)
  if l:index < 0
    let l:index = 0
  else
    let l:index = (l:index + a:direction + len(l:buffers)) % len(l:buffers)
  endif

  return l:buffers[l:index]
endfunction

function! s:BufferSwitch(direction) abort
  let l:target = s:TargetFileBuffer(a:direction)
  if l:target < 0
    return
  endif

  call s:GoToFileWindowForBufferSwitch()
  execute 'buffer ' . l:target
  call QueryVSRememberFileWindow()
endfunction

command! BufferNextSmart call s:BufferSwitch(1)
command! BufferPrevSmart call s:BufferSwitch(-1)

function! s:HasWindowInDirection(direction) abort
  let l:current = win_getid()
  execute 'silent! wincmd ' . a:direction
  let l:moved = win_getid() != l:current
  call win_gotoid(l:current)
  return l:moved
endfunction

function! QueryVSResizeHeight(amount) abort
  if !s:HasWindowInDirection('j') && !s:HasWindowInDirection('k')
    return
  endif

  execute 'resize ' . (a:amount >= 0 ? '+' : '') . a:amount
endfunction

function! QueryVSTabLine() abort
  let l:line = ''
  for l:i in range(1, tabpagenr('$'))
    let l:winnr = tabpagewinnr(l:i)
    let l:bufnr = tabpagebuflist(l:i)[l:winnr - 1]
    let l:custom = gettabvar(l:i, 'queryvs_tab_label', '')
    let l:name = bufname(l:bufnr)
    let l:ft = getbufvar(l:bufnr, '&filetype')
    let l:bt = getbufvar(l:bufnr, '&buftype')

    if !empty(l:custom)
      let l:label = l:custom
    elseif l:ft ==# 'neo-tree'
      let l:label = 'Neo-tree'
    elseif l:bt ==# 'terminal'
      let l:label = 'Terminal'
    elseif empty(l:name)
      let l:label = '[No Name]'
    else
      let l:label = fnamemodify(l:name, ':t')
    endif

    if empty(l:label)
      let l:label = '[No Name]'
    endif

    let l:hl = l:i == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#'
    let l:line .= l:hl . '%' . l:i . 'T ' . l:i . ':' . l:label . ' '
  endfor

  let l:line .= '%#TabLineFill#%T'
  return l:line
endfunction

augroup queryvs_focus_dir
  autocmd!
  autocmd BufEnter,WinEnter * call QueryVSRememberFileWindow()
  autocmd BufEnter * if filereadable(expand('%:p')) | let g:queryvs_last_file_dir = expand('%:p:h') | endif
augroup END
