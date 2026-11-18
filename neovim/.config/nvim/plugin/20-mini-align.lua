-- align text
-- https://github.com/nvim-mini/mini.align

vim.pack.add({
  {
    src = "https://github.com/nvim-mini/mini.align",
    version = "stable"
  },
})

require("mini.align").setup({})
