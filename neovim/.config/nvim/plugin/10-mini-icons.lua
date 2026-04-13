-- icons
-- https://github.com/nvim-mini/mini.icons

vim.pack.add({
  {
    src = "https://github.com/nvim-mini/mini.icons",
    version = vim.version.range("*"),
  },
})

require("mini.icons").setup({})
