-- autopairing
-- https://github.com/nvim-mini/mini.pairs

vim.pack.add({
  {
    src = "https://github.com/nvim-mini/mini.pairs",
    version = vim.version.range("*"),
  },
})

require("mini.pairs").setup({})
