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
    on_colors = function(colors)
      colors.border = colors.fg_gutter
    end,
  },

  config = function(_, opts)
    vim.o.background = "dark"

    require("tokyonight").setup(opts)

    vim.cmd("colorscheme tokyonight")
  end,
}
