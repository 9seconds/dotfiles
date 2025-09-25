-- copilot
-- https://github.com/zbirenbaum/copilot.lua

return {
  "zbirenbaum/copilot.lua",
  dependencies = {
    {
      "copilotlsp-nvim/copilot-lsp",
      init = function()
        vim.g.copilot_nes_debounce = 500
        vim.lsp.enable("copilot_ls")
      end,
    },
  },
  cmd = "Copilot",
  event = "InsertEnter",

  opts = {
    panel = {
      enabled = false,
    },
    suggestion = {
      enabled = true,
      keymap = {
        accept = "<c-a>",
        next = "<c-c>",
        accept_word = "<c-w>",
        accept_line = "<c-l>",
        dismiss = "<c-d>",
      },
    },
    nes = {
      enabled = false,
      keymap = {
        accept_and_goto = "<c-i>",
        dismiss = "<esc>",
      },
    },
  },
}
