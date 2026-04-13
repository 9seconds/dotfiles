-- copilot
-- https://github.com/zbirenbaum/copilot.lua

vim.pack.add({
  {
    src = "https://github.com/zbirenbaum/copilot.lua",
    version = vim.version.range("*"),
  },
})

require("copilot").setup({
  panel = {
    enabled = false,
  },
  suggestion = {
    enabled = false,
  },
})
