-- show function context
-- https://github.com/nvim-treesitter/nvim-treesitter-context

vim.pack.add({
  "https://github.com/nvim-treesitter/nvim-treesitter-context",
})

require("treesitter-context").setup({
  enable = true,
  max_lines = 10,
  separator = "-",
})
