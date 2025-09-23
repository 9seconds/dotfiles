-- copilot
-- https://github.com/zbirenbaum/copilot.lua

return {
  "zbirenbaum/copilot.lua",
  dependencies = {
    "copilotlsp-nvim/copilot-lsp",
  },
  cmd = {
    "Copilot",
  },
  event = {
    "InsertEnter",
  },

  init = function()
    vim.g.copilot_nes_debounce = 500
    vim.lsp.enable("copilot_ls")
  end,

  opts = {
    panel = {
      enabled = false,
    },
    suggestion = {
      enabled = false,
    },
  },
}
