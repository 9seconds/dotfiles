-- copilot
-- https://github.com/zbirenbaum/copilot.lua

require("_.pack").add({
  url = "https://github.com/zbirenbaum/copilot.lua",
  config = function()
    require("copilot").setup({
      panel = {
        enabled = false,
      },
      suggestion = {
        enabled = false,
      },
    })
  end,
})
