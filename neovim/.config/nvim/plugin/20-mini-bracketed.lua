-- bracketed movements
-- https://github.com/nvim-mini/mini.bracketed

vim.pack.add({
  {
    src = "https://github.com/nvim-mini/mini.bracketed",
    version = vim.version.range("*"),
  },
})

require("mini.bracketed").setup({})
