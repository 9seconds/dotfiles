-- tokyonight colorscheme
-- https://github.com/folke/tokyonight.nvim

return {
  "folke/tokyonight.nvim",
  version = "*",
  lazy = false,
  priority = 1000,

  opts = {
    dim_inactive = true,
    lualine_bold = true,
  },

  init = function()
    vim.o.background = "dark"
  end,

  config = function()
    vim.cmd("colorscheme tokyonight")
  end,
}
