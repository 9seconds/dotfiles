-- better formatting
-- https://github.com/stevearc/conform.nvim

local FORMAT_TIMEOUT = 10000

return {
  "stevearc/conform.nvim",
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({
          timeout_ms = FORMAT_TIMEOUT,
          lsp_fallback = true,
        })
      end,
      mode = { "n", "x", "v" },
      desc = "Run formatter",
    },
  },

  config = function()
    local formatters = require("_.tools").configs.formatters

    require("conform").setup({
      formatters_by_ft = formatters.filetypes,
      formatters = formatters.settings,
    })
  end,
}
