-- sort enhancements
-- https://github.com/sQVe/sort.nvim

vim.pack.add({
  {
    src = "https://github.com/sQVe/sort.nvim",
    version = vim.version.range("*"),
  },
})

require("sort").setup({})
