" Plugin declarations.

call plug#begin('~/.config/nvim/plugged')

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'MunifTanjim/nui.nvim'
Plug 'nvim-neo-tree/neo-tree.nvim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'junegunn/vim-easy-align'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Treesitter handles syntax for modern languages; keep polyglot disabled to
" avoid BufWinEnter/<afile> startup errors on unnamed buffers.
" Plug 'sheerun/vim-polyglot'
Plug 'nvim-mini/mini.nvim'

Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'ellisonleao/glow.nvim'
Plug 'MeanderingProgrammer/render-markdown.nvim'

call plug#end()
