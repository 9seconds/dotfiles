-- Smart split/join
-- https://github.com/Wansmer/treesj


return {
  "Wansmer/treesj",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  keys = {
    {
      "<leader>s",
      "<cmd>TSJSplit<cr>",
      desc = "Split long lines with treesj"
    },
    {
      "<leader>j",
      "<cmd>TSJJoin<cr>",
      desc = "Join long lines with treesj"
    },
  },

  opts = {
    use_default_keymaps = false,
  }
}
