-- better formatting
-- https://github.com/stevearc/conform.nvim

return {
  "stevearc/conform.nvim",
  event = "VeryLazy",

  config = function()
    local tools = require("_.tools")

    vim.o.formatexpr = "v:lua.require('conform').formatexpr()"

    require("conform").setup({
      formatters_by_ft = tools.configs.formatters.filetypes,
      formatters = tools.configs.formatters.settings,
    })
  end,
}
