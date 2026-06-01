" QueryVS Neovim config -> ~/.config/nvim/init.vim
" Dependencies: vim-plug, nodejs/npm for coc.nvim.
" Run :PlugInstall after adding/changing plugins.

set encoding=utf-8
scriptencoding utf-8

let mapleader = " "
let maplocalleader = ","

source ~/.config/nvim/config/plugins.vim
source ~/.config/nvim/config/options.vim
source ~/.config/nvim/config/functions.vim
source ~/.config/nvim/config/terminal.vim
source ~/.config/nvim/config/keymaps.vim
source ~/.config/nvim/config/coc.vim
source ~/.config/nvim/config/review.vim

lua require("queryvs.ui")
lua require("queryvs.neotree")
lua require("queryvs.tools")
