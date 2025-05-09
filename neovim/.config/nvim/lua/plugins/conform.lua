-- formatting
-- https://github.com/stevearc/conform.nvim

return {
  "stevearc/conform.nvim",
  version = "*",
  keys = {
    {
      "<leader>=",
      function()
        require("conform").format({
          async = true,
        })
      end,
      mode = { "n", "v" },
      desc = "Format with conform",
    },
  },
  cmd = {
    "ConformInfo",
  },

  opts = {
    default_format_opts = {
      lsp_format = "fallback",
    },
  },

  config = function(_, opts)
    local conf = require("_.conform")

    opts = vim.tbl_extend("force", opts, conf:get_config())

    require("conform").setup(opts)
  end,
}
