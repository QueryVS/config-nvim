local function safe_require(name)
  local ok, mod = pcall(require, name)
  if ok then
    return mod
  end
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
  if mod then
    mod.setup()
  end
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
      { mode = "n", keys = "<Leader>a", desc = "+ALE / align" },
      { mode = "n", keys = "<Leader>b", desc = "+Buffers" },
      { mode = "n", keys = "<Leader>c", desc = "+Code" },
      { mode = "x", keys = "<Leader>c", desc = "+Code" },
      { mode = "n", keys = "<Leader>f", desc = "+Find" },
      { mode = "n", keys = "<Leader>g", desc = "+Git" },
      { mode = "n", keys = "<Leader>m", desc = "+Markdown" },
      { mode = "n", keys = "<Leader>r", desc = "+Resize" },
      { mode = "n", keys = "<Leader>t", desc = "+Tabs / terminal" },
      clue.gen_clues.builtin_completion(),
      clue.gen_clues.g(),
      clue.gen_clues.marks(),
      clue.gen_clues.registers(),
      clue.gen_clues.windows(),
      clue.gen_clues.z(),
    },
  })
end

vim.keymap.set("n", "<leader>ff", function()
  require("mini.pick").builtin.files()
end, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", function()
  require("mini.pick").builtin.grep_live()
end, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", function()
  require("mini.pick").builtin.buffers()
end, { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fh", function()
  require("mini.pick").builtin.help()
end, { desc = "Help tags" })
vim.keymap.set("n", "<leader>fr", function()
  require("mini.pick").builtin.resume()
end, { desc = "Resume picker" })
vim.keymap.set("n", "<leader>fm", "<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0), false)<CR>", { desc = "Mini files" })
vim.keymap.set("n", "<leader>td", "<cmd>lua MiniTrailspace.trim()<CR>", { desc = "Trim trailing whitespace" })
vim.keymap.set("n", "<leader>md", "<cmd>RenderMarkdown toggle<CR>", { desc = "Toggle markdown render" })
vim.keymap.set("n", "<leader>mp", "<cmd>Glow<CR>", { desc = "Markdown preview" })
