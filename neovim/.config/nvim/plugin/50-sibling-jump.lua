-- fast treesitter navigation
-- https://github.com/subev/sibling-jump.nvim

vim.pack.add({
  "https://github.com/subev/sibling-jump.nvim",
})

require("sibling_jump").setup({
  next_key = "<A-j>",
  prev_key = "<A-k>",
  block_loop_key = "<A-l>",
  center_on_jump = true,
  block_loop_center_on_jump = true,
})
