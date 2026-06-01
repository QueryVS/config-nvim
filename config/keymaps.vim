" Core keymaps.

nnoremap <silent> <Esc> :nohlsearch<CR>
nnoremap <silent> <leader>w :write<CR>
nnoremap <silent> <leader>q :quit<CR>
nnoremap <silent> <leader>x :bdelete<CR>
nnoremap <silent> <leader>sv :source $MYVIMRC<CR>

nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-l> <C-w>l
nnoremap <silent> <leader><Left> :vertical resize -5<CR>
nnoremap <silent> <leader><Right> :vertical resize +5<CR>
nnoremap <silent> <leader><Up> :resize +3<CR>
nnoremap <silent> <leader><Down> :resize -3<CR>
nnoremap <silent> <A-H> :vertical resize -5<CR>
nnoremap <silent> <A-L> :vertical resize +5<CR>
nnoremap <silent> <A-J> :resize -3<CR>
nnoremap <silent> <A-K> :resize +3<CR>
nnoremap <silent> <leader>rh :vertical resize -5<CR>
nnoremap <silent> <leader>rl :vertical resize +5<CR>
nnoremap <silent> <leader>rj :resize -3<CR>
nnoremap <silent> <leader>rk :resize +3<CR>
nnoremap <silent> <leader>r= <C-w>=
nnoremap <silent> <leader>rm <C-w>_<C-w>\|

nnoremap <silent> <leader>bn :bnext<CR>
nnoremap <silent> <leader>bp :bprevious<CR>
nnoremap <silent> <Tab> :tabnext<CR>
nnoremap <silent> <S-Tab> :tabprevious<CR>
nnoremap <silent> <leader>tp :tabprevious<CR>
nnoremap <silent> <leader>tl :tabnext<CR>
nnoremap <silent> <leader>tn :tabnew<CR>
nnoremap <silent> <leader>tc :tabclose<CR>

nnoremap <silent> <leader>e :Neotree toggle reveal<CR>
nnoremap <silent> <C-n> :Neotree toggle reveal<CR>
nnoremap <silent> <leader>tt :TerminalPanel<CR>
nnoremap <silent> <leader>tv :TerminalVPanel<CR>
nnoremap <silent> <leader>tf :TerminalHere<CR>
nnoremap <silent> <leader>tF :TerminalVHere<CR>
nnoremap <silent> <leader>tN :TerminalTab<CR>
nnoremap <silent> <C-t> :TerminalTab<CR>
tnoremap <Esc> <C-\><C-n>
tnoremap <Esc><Esc> <C-\><C-n>
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

nnoremap <leader>a <Plug>(EasyAlign)
xnoremap <leader>a <Plug>(EasyAlign)
