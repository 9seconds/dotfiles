-- Copilot stuff
-- https://github.com/zbirenbaum/copilot.lua

return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",

  opts = {
    panel = {
      enabled = false,
    },
    suggestion = {
      enabled = true,
      auto_trigger = true,
      keymap = {
        accept = "<M-l>",
        accept_word = "<M-w>",
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<M-x>",
      },
    },
  },
}
