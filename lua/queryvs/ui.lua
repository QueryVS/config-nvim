local function safe_require(name)
  local ok, mod = pcall(require, name)
  if ok then
    return mod
  end
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
