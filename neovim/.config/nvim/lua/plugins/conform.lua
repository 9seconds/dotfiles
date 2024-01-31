-- better formatting
-- https://github.com/stevearc/conform.nvim

return {
  "stevearc/conform.nvim",
  event = "VeryLazy",

  init = function()
    vim.o.formatexpr = "v:lua.require('conform').formatexpr()"
  end,

  config = function()
    local formatters = require("_.tools").configs.formatters

    require("conform").setup({
      formatters_by_ft = formatters.filetypes,
      formatters = formatters.settings,
    })
  end,
}
