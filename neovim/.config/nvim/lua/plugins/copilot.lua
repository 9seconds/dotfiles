-- Copilot stuff
-- https://github.com/zbirenbaum/copilot.lua

return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  keys = {
    {
      "<C-c>",
      function()
        require("_.copilot"):user_toggle()
      end,
      mode = { "n", "i", "o" },
      desc = "Toggle Copilot",
    },
  },

  config = function()
    require("copilot").setup({
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
    })
    require("_.copilot"):activate()
  end,
}
