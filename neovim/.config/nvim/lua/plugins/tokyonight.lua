-- tokyonight colorscheme
-- https://github.com/folke/tokyonight.nvim


return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,

  config = function()
    require("tokyonight").setup({
      hide_inactive_statusline = true,
      dim_inactive = true,
      lualine_bold = true,
    })
    vim.cmd("colorscheme tokyonight")
  end,
}
