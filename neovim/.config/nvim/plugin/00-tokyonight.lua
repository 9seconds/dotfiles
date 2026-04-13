-- tokyonight colorscheme
-- https://github.com/folke/tokyonight.nvim

vim.pack.add({
  {
    src = "https://github.com/folke/tokyonight.nvim",
    version = vim.version.range("*"),
  },
})

vim.o.background = "dark"

require("tokyonight").setup({
  dim_inactive = true,
  lualine_bold = true,
  on_colors = function(colors)
    colors.border = colors.fg_gutter
  end,
})

vim.cmd("colorscheme tokyonight")
