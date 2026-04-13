-- better splitjoin
-- https://github.com/nvim-mini/mini.splitjoin

vim.pack.add({
  {
    src = "https://github.com/nvim-mini/mini.splitjoin",
    version = vim.version.range("*"),
  },
})

require("mini.splitjoin").setup({
  mappings = {
    toggle = "<leader>j",
  },
})
