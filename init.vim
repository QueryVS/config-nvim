" QueryVS Neovim config -> ~/.config/nvim/init.vim
" Dependencies: vim-plug, nodejs/npm for coc.nvim.
" Run :PlugInstall after adding/changing plugins.

set encoding=utf-8
scriptencoding utf-8

let mapleader = " "
let maplocalleader = ","

" -----------------------------
" Plugins
" -----------------------------
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

" -----------------------------
" Editor defaults
" -----------------------------
set number
set relativenumber
set cursorline
set signcolumn=yes
set colorcolumn=100
set scrolloff=8
set sidescrolloff=8
set splitbelow
set splitright
set hidden
set updatetime=300
set timeoutlen=1200
set mouse=a
set clipboard=unnamedplus
set undofile
set ignorecase
set smartcase
set incsearch
set hlsearch
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smartindent
set completeopt=menuone,noinsert,noselect
set shortmess+=c
set conceallevel=2
set concealcursor=nc
set list
set listchars=tab:»\ ,trail:·,extends:>,precedes:<,nbsp:+
set showtabline=2
set tabline=%!QueryVSTabLine()

filetype plugin indent on
syntax enable

" -----------------------------
" Core keymaps
" -----------------------------
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

let g:queryvs_terminal_buf = -1
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

function! s:RememberFileWindow() abort
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
  call s:RememberFileWindow()
endfunction

command! BufferNextSmart call s:BufferSwitch(1)
command! BufferPrevSmart call s:BufferSwitch(-1)

function! QueryVSTabLine() abort
  let l:line = ''
  for l:i in range(1, tabpagenr('$'))
    let l:winnr = tabpagewinnr(l:i)
    let l:bufnr = tabpagebuflist(l:i)[l:winnr - 1]
    let l:name = bufname(l:bufnr)
    let l:ft = getbufvar(l:bufnr, '&filetype')
    let l:bt = getbufvar(l:bufnr, '&buftype')

    if l:ft ==# 'neo-tree'
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
  terminal
  startinsert
endfunction

command! TerminalPanel call s:OpenTerminalPanel(0, 0)
command! TerminalVPanel call s:OpenTerminalPanel(1, 0)
command! TerminalHere call s:OpenTerminalPanel(0, 1)
command! TerminalVHere call s:OpenTerminalPanel(1, 1)
command! TerminalTab call s:OpenTerminalTab()

augroup queryvs_focus_dir
  autocmd!
  autocmd BufEnter,WinEnter * call <SID>RememberFileWindow()
  autocmd BufEnter * if filereadable(expand('%:p')) | let g:queryvs_last_file_dir = expand('%:p:h') | endif
augroup END

" -----------------------------
" CoC: completion, navigation, refactor
" -----------------------------
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

" -----------------------------
" Review / Git / diagnostics
" -----------------------------
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

" -----------------------------
" Lua plugin setup
" -----------------------------
lua << EOF
local function safe_require(name)
  local ok, mod = pcall(require, name)
  if ok then return mod end
end

local catppuccin = safe_require("catppuccin")
if catppuccin then
  local ok = pcall(catppuccin.setup, {
    flavour = "frappe",
    transparent_background = true,
    term_colors = true,
    no_italic = true,
    no_bold = false,
    styles = {
      comments = { "italic" },
      keywords = {},
      functions = {},
      strings = {},
      variables = {},
    },
    color_overrides = {
      frappe = {
        base = "#1b1f1f",
        mantle = "#1b1f1f",
        crust = "#151818",
        text = "#d3d1c8",
        subtext1 = "#c0ba9f",
        overlay2 = "#928e78",
        surface2 = "#706c54",
        surface1 = "#5f5b47",
        surface0 = "#49473a",
        lavender = "#8dbf27",
        rosewater = "#a37d2e",
        peach = "#c48b33",
        green = "#789d22",
        teal = "#4c8a7a",
        sky = "#5ea19c",
      },
    },
    custom_highlights = function()
      return {
        Cursor = { bg = "#8dbf27", fg = "#1b1f1f" },
        Visual = { bg = "#3b4737" },
        LineNr = { fg = "#5e5e56" },
        CursorLineNr = { fg = "#c9c9b2", bold = true },
        Comment = { fg = "#A8A8A8", italic = true },
        Function = { fg = "#a37d2e" },
        Keyword = { fg = "#ba8f6a", bold = true },
        String = { fg = "#8ea56b" },
      }
    end,
  })
  if ok then
    pcall(vim.cmd.colorscheme, "catppuccin")
  end
end

local neo_tree = safe_require("neo-tree")
if neo_tree then
  -- neo-tree clears the legacy netrw FileExplorer group during setup. Defining
  -- it first prevents startup noise when netrw has not created it yet.
  vim.cmd("augroup FileExplorer | augroup END")

  local function remember_neo_tree_dir(node)
    if not node or not node.path then
      return
    end
    if node.type == "directory" then
      vim.g.queryvs_last_file_dir = node.path
    elseif node.type == "file" then
      vim.g.queryvs_last_file_dir = vim.fn.fnamemodify(node.path, ":h")
    end
  end

  local function run_neo_tree_command_keep_focus(state, command)
    local node = state.tree:get_node()
    if not node then
      return
    end

    remember_neo_tree_dir(node)
    local fs_commands = require("neo-tree.sources.filesystem.commands")

    if node.type ~= "file" then
      fs_commands.open(state)
      return
    end

    local tree_win = vim.api.nvim_get_current_win()

    fs_commands[command](state)

    if vim.api.nvim_win_is_valid(tree_win) then
      vim.api.nvim_set_current_win(tree_win)
    end
  end

  local function file_is_open_in_tab(path)
    local target = vim.fn.fnamemodify(path, ":p")

    for tab = 1, vim.fn.tabpagenr("$") do
      local buffers = vim.fn.tabpagebuflist(tab)
      for _, bufnr in ipairs(buffers) do
        local name = vim.api.nvim_buf_get_name(bufnr)
        if name ~= "" and vim.fn.fnamemodify(name, ":p") == target then
          return true
        end
      end
    end

    return false
  end

  local function open_neo_tree_file_in_tab(state)
    local node = state.tree:get_node()
    if not node then
      return
    end

    remember_neo_tree_dir(node)
    if node.type ~= "file" then
      require("neo-tree.sources.filesystem.commands").open(state)
      return
    end

    local current_tab = vim.api.nvim_get_current_tabpage()
    if file_is_open_in_tab(node.path) then
      vim.cmd("Neotree focus")
      return
    end

    vim.cmd("tabnew " .. vim.fn.fnameescape(node.path))
    vim.api.nvim_set_current_tabpage(current_tab)
    vim.cmd("Neotree focus")
  end

  local function open_neo_tree_file_normal(state)
    local node = state.tree:get_node()
    if not node then
      return
    end

    remember_neo_tree_dir(node)
    if node.type ~= "file" then
      require("neo-tree.sources.filesystem.commands").open(state)
      return
    end

    run_neo_tree_command_keep_focus(state, "open")
  end

  neo_tree.setup({
    close_if_last_window = true,
    enable_git_status = true,
    enable_diagnostics = true,
    window = {
      width = 32,
      mappings = {
        ["<CR>"] = function(state)
          open_neo_tree_file_in_tab(state)
        end,
        ["o"] = function(state)
          open_neo_tree_file_in_tab(state)
        end,
        ["e"] = function(state)
          open_neo_tree_file_normal(state)
        end,
        ["s"] = function(state)
          run_neo_tree_command_keep_focus(state, "open_vsplit")
        end,
        ["S"] = function(state)
          run_neo_tree_command_keep_focus(state, "open_split")
        end,
        ["v"] = function(state)
          run_neo_tree_command_keep_focus(state, "open_vsplit")
        end,
        ["T"] = function(state)
          remember_neo_tree_dir(state.tree:get_node())
          vim.cmd("TerminalHere")
        end,
        ["t"] = function(state)
          open_neo_tree_file_in_tab(state)
        end,
      },
    },
    filesystem = {
      hijack_netrw_behavior = "disabled",
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = false,
      },
    },
    default_component_configs = {
      icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "",
        folder_empty_open = "",
      },
    },
    highlight_groups = {
      NeoTreeDirectoryIcon = { fg = "#ba8f6a" },
      NeoTreeDirectoryName = { fg = "#d9a77c", bold = true },
      NeoTreeDirectoryOpenedName = { fg = "#a2d846" },
      NeoTreeRootName = { fg = "#c0ba9f", bold = true },
    },
  })
end

local treesitter = safe_require("nvim-treesitter.configs")
if treesitter then
  treesitter.setup({
    highlight = { enable = true },
    indent = { enable = true },
  })
end

local markdown = safe_require("render-markdown")
if markdown then
  markdown.setup({
    heading = { enabled = true },
    code = { enabled = true },
    bullet = { enabled = true },
    checkbox = { enabled = true },
  })
end

local mini_modules = {
  "ai",
  "bracketed",
  "bufremove",
  "cursorword",
  "diff",
  "files",
  "hipatterns",
  "indentscope",
  "pairs",
  "pick",
  "splitjoin",
  "statusline",
  "surround",
  "trailspace",
}

for _, name in ipairs(mini_modules) do
  local mod = safe_require("mini." .. name)
  if mod then mod.setup() end
end

local clue = safe_require("mini.clue")
if clue then
  clue.setup({
    triggers = {
      { mode = "n", keys = "<Leader>" },
      { mode = "x", keys = "<Leader>" },
      { mode = "n", keys = "g" },
      { mode = "n", keys = "[" },
      { mode = "n", keys = "]" },
      { mode = "i", keys = "<C-x>" },
    },
    clues = {
      clue.gen_clues.builtin_completion(),
      clue.gen_clues.g(),
      clue.gen_clues.marks(),
      clue.gen_clues.registers(),
      clue.gen_clues.windows(),
      clue.gen_clues.z(),
    },
  })
end

vim.keymap.set("n", "<leader>ff", function() require("mini.pick").builtin.files() end, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", function() require("mini.pick").builtin.grep_live() end, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", function() require("mini.pick").builtin.buffers() end, { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fh", function() require("mini.pick").builtin.help() end, { desc = "Help tags" })
vim.keymap.set("n", "<leader>fr", function() require("mini.pick").builtin.resume() end, { desc = "Resume picker" })
vim.keymap.set("n", "<leader>fm", "<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0), false)<CR>", { desc = "Mini files" })
vim.keymap.set("n", "<leader>td", "<cmd>lua MiniTrailspace.trim()<CR>", { desc = "Trim trailing whitespace" })
vim.keymap.set("n", "<leader>md", "<cmd>RenderMarkdown toggle<CR>", { desc = "Toggle markdown render" })
vim.keymap.set("n", "<leader>mp", "<cmd>Glow<CR>", { desc = "Markdown preview" })

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 and not vim.g.started_by_firenvim then
      vim.cmd("Neotree focus")
    end
  end,
})
EOF
