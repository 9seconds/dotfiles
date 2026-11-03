-- nice diff/merger
-- https://github.com/CoreyKaylor/diffbandit.nvim

vim.pack.add({
  {
    src = "https://github.com/CoreyKaylor/diffbandit.nvim",
    version = vim.version.range("*"),
  },
})

require("diffbandit").setup()
