-- Create Git links
-- https://github.com/linrongbin16/gitlinker.nvim

vim.pack.add({
  {
    src = "https://github.com/linrongbin16/gitlinker.nvim",
    version = vim.version.range("*"),
  },
})

require("gitlinker").setup({})
