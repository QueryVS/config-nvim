" Project-local session save.

function! QueryVSSessionFile() abort
  return getcwd() . '/Session.vim'
endfunction

function! s:NeoTreeIsOpen() abort
  for l:win in getwininfo()
    if getbufvar(l:win.bufnr, '&filetype') ==# 'neo-tree'
      return 1
    endif
  endfor
  return 0
endfunction

function! s:CloseNeoTreeForSession() abort
  if s:NeoTreeIsOpen()
    silent! lua require("neo-tree").close_all()
    return 1
  endif
  return 0
endfunction

function! s:ReopenNeoTreeAfterSession(should_reopen) abort
  if a:should_reopen
    call timer_start(0, {-> execute('silent! Neotree show')})
  endif
endfunction

function! QueryVSSaveSession() abort
  let l:session = QueryVSSessionFile()
  let l:restore_tree = s:CloseNeoTreeForSession()
  execute 'mksession! ' . fnameescape(l:session)
  call s:ReopenNeoTreeAfterSession(l:restore_tree)
  echo 'Session saved: ' . l:session
endfunction

function! QueryVSLoadSession() abort
  let l:session = QueryVSSessionFile()
  if !filereadable(l:session)
    echoerr 'Session not found: ' . l:session
    return
  endif

  let l:restore_tree = s:CloseNeoTreeForSession()
  execute 'source ' . fnameescape(l:session)
  call s:ReopenNeoTreeAfterSession(l:restore_tree)
endfunction

