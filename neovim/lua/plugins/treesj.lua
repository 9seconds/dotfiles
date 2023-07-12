-- Smart split/join
-- https://github.com/Wansmer/treesj


return {
  "Wansmer/treesj",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  keys = {
    {"<leader>s", "<cmd>TSJSplit<cr>"},
    {"<leader>j", "<cmd>TSJJoin<cr>"},
  },

  opts = {
    use_default_keymaps = false,
  }
}
