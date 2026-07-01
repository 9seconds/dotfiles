-- colorscheme
-- https://github.com/webhooked/kanso.nvim

vim.pack.add({
  "https://github.com/webhooked/kanso.nvim",
})

vim.o.background = "dark"

require("kanso").setup({
  compile = true,
  dimInactive = true,
  background = {
    dark = "ink",
    light = "pearl",
  },
  foreground = {
    dark = "default",
    light = "default",
  },
})

vim.cmd("colorscheme kanso")
