" CoC completion, navigation, and refactor mappings.

inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <silent><expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
xmap <leader>cf <Plug>(coc-format-selected)
nmap <leader>cf <Plug>(coc-format-selected)
nmap <leader>ca <Plug>(coc-codeaction-cursor)
xmap <leader>ca <Plug>(coc-codeaction-selected)
nnoremap <silent> K :call ShowDocumentation()<CR>
nnoremap <silent> <leader>cd :CocDiagnostics<CR>
nnoremap <silent> <leader>cl :CocList<CR>
nnoremap <silent> <leader>co :CocList outline<CR>
nnoremap <silent> <leader>cs :CocList -I symbols<CR>

function! ShowDocumentation() abort
  if exists('*CocAction') && exists('*CocActionAsync') && CocAction('hasProvider', 'hover')
    silent! call CocActionAsync('doHover')
  else
    execute 'h ' . expand('<cword>')
  endif
endfunction

augroup coc_user_actions
  autocmd!
  autocmd CursorHold * if exists('*CocActionAsync') | silent! call CocActionAsync('highlight') | endif
augroup END
