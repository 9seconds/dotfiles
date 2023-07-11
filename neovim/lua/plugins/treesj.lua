-- Smart split/join
-- https://github.com/Wansmer/treesj


return {
  "Wansmer/treesj",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  keys = {
    {"<leader>S", "<cmd>TSJSplit<cr>"},
    {"<leader>J", "<cmd>TSJJoin<cr>"},
  },

  opts = {
    use_default_keymaps = false,
  }
}
