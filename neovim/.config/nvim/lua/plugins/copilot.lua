-- copilot
-- https://github.com/zbirenbaum/copilot.lua

return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  keys = {
    {
      "<C-c>",
      function()
        local copilot = require("copilot.suggestion")
        local blink = package.loaded["blink.cmp"]

        copilot.toggle_auto_trigger()
        copilot.dismiss()

        if blink then
          blink.hide()
        end
      end,
      mode = { "n", "i", "v" },
      desc = "Toggle Copilot",
    },
  },

  opts = {
    panel = {
      enabled = false,
    },
    suggestion = {
      enabled = true,
      auto_trigger = false,
      keymap = {
        accept = "<C-a>",
        accept_word = "<M-w>",
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-q>",
      },
    },
  },
}
