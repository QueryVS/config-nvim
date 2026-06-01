" Review, Git, and diagnostics.

nnoremap <silent> <leader>gs :Git<CR>
nnoremap <silent> <leader>gb :Git blame<CR>
nnoremap <silent> <leader>gD :Gvdiffsplit!<CR>
nnoremap <silent> <leader>gl :Gclog<CR>
nnoremap <silent> <leader>gp :Git push<CR>
nnoremap <silent> <leader>gP :Git pull<CR>
nnoremap <silent> <leader>aa :ALEToggle<CR>
nnoremap <silent> <leader>ad :ALEDetail<CR>
nnoremap <silent> <leader>af :ALEFix<CR>
nnoremap <silent> <leader>al :lopen<CR>
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]q :cnext<CR>
nnoremap <silent> [l :lprevious<CR>
nnoremap <silent> ]l :lnext<CR>

let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:ale_fix_on_save = 0
let g:ale_sign_error = 'E'
let g:ale_sign_warning = 'W'
let g:ale_virtualtext_cursor = 1
