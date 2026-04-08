-- tokyonight colorscheme
-- https://github.com/folke/tokyonight.nvim

require("_.pack").add({
  url = "https://github.com/folke/tokyonight.nvim",
  releases = true,
  config = function()
    vim.o.background = "dark"

    require("tokyonight").setup({
      dim_inactive = true,
      lualine_bold = true,
      on_colors = function(colors)
        colors.border = colors.fg_gutter
      end,
    })

    vim.cmd("colorscheme tokyonight")
  end
})
