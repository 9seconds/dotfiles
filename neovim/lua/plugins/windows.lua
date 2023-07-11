-- window management
-- https://github.com/anuvyklack/windows.nvim


return {
  "anuvyklack/windows.nvim",
  dependencies = {
    "anuvyklack/middleclass"
  },
  keys = {
    {"<leader>Z", "<cmd>WindowsMaximize<cr>"}
  },

  opts = {}
}
