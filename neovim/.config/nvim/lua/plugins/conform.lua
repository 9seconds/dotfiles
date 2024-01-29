-- better formatting
-- https://github.com/stevearc/conform.nvim


return {
  "stevearc/conform.nvim",
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({
          async = true,
          lsp_fallback = true,
        })
      end,
      mode = {"n", "v"},
      desc = "Format with conform",
    },
  },
  cmd = { "ConformInfo" },

  config = function()
    local tools = require("_.tools")

    require("conform").setup({
      formatters_by_ft = tools.configs.formatters.filetypes,
      formatters = tools.configs.formatters.settings,
    })
  end
}
