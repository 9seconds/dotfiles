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

  config = function()
    vim.cmd("colorscheme tokyonight")
  end,
}
