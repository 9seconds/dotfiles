-- diagnostics wrapper
-- https://github.com/folke/trouble.nvim

return {
  "folke/trouble.nvim",
  version = "*",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "echasnovski/mini.icons",
  },
  keys = {
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle focus=false filter.buf=0<cr>",
      desc = "Toggle buffer diagnostics",
    },
    {
      "<leader>xX",
      "<cmd>Trouble diagnostics toggle focus=false<cr>",
      desc = "Toggle workspace diagnostics",
    },
    {
      "<leader>xi",
      "<cmd>Trouble lsp_incoming_calls toggle<cr>",
      desc = "Show incoming calls",
    },
    {
      "<leader>xo",
      "<cmd>Trouble lsp_outgoing_calls toggle<cr>",
      desc = "Show outgoing calls",
    },
    {
      "<leader>xr",
      "<cmd>Trouble lsp_references toggle<cr>",
      desc = "Toggle quickfix",
    },
  },
  cmd = { "Trouble" },

  opts = {},
}
