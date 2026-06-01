local ok, neo_tree = pcall(require, "neo-tree")
if not ok then
  return
end

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
      ["<CR>"] = open_neo_tree_file_in_tab,
      ["o"] = open_neo_tree_file_in_tab,
      ["e"] = open_neo_tree_file_normal,
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
      ["t"] = open_neo_tree_file_in_tab,
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

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 and not vim.g.started_by_firenvim then
      vim.cmd("Neotree focus")
    end
  end,
})
