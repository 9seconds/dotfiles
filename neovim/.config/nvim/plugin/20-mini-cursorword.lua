-- show a word under cursor
-- https://github.com/nvim-mini/mini.cursorword

vim.pack.add({
  {
    src = "https://github.com/nvim-mini/mini.cursorword",
    version = vim.version.range("*"),
  },
})

require("mini.cursorword").setup({})
