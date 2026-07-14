-- fast jumps
-- https://github.com/nvim-mini/mini.jump2d

vim.pack.add({
  {
    src = "https://github.com/nvim-mini/mini.jump2d",
    version = vim.version.range("*"),
  },
})

require("mini.jump2d").setup({
  view = {
    dim = true,
  },
})
