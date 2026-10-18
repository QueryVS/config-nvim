local function safe_require(name)
  local ok, mod = pcall(require, name)
  if ok then
    return mod
  end
end

local function apply_window_highlights()
  -- Keep splits visible while letting the focused window remain calm.
  vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#706c54" })
  vim.api.nvim_set_hl(0, "VertSplit", { fg = "#706c54" })
  vim.api.nvim_set_hl(0, "NormalNC", { bg = "#181b1b" })
  vim.api.nvim_set_hl(0, "CursorLine", { bg = "#2a3028" })
  vim.api.nvim_set_hl(0, "StatusLine", { bg = "#30362e", fg = "#d3d1c8" })
  vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "#222625", fg = "#928e78" })
  vim.api.nvim_set_hl(0, "MiniStatuslineFilename", { bg = "#3b4737", fg = "#d3d1c8", bold = true })
  vim.api.nvim_set_hl(0, "MiniStatuslineInactive", { bg = "#222625", fg = "#928e78" })
  vim.api.nvim_set_hl(0, "TabLine", { bg = "#222625", fg = "#928e78" })
  vim.api.nvim_set_hl(0, "TabLineSel", { bg = "#3b4737", fg = "#d3d1c8", bold = true })
  vim.api.nvim_set_hl(0, "TabLineFill", { bg = "#181b1b" })
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
        WinSeparator = { fg = "#706c54" },
        VertSplit = { fg = "#706c54" },
        NormalNC = { bg = "#181b1b" },
        CursorLine = { bg = "#2a3028" },
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

apply_window_highlights()

vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("QueryVSWindowHighlights", { clear = true }),
  callback = apply_window_highlights,
})

vim.api.nvim_create_autocmd("VimEnter", {
  group = "QueryVSWindowHighlights",
  callback = apply_window_highlights,
})
