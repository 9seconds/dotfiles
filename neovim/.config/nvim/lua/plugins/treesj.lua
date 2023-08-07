-- Smart split/join
-- https://github.com/Wansmer/treesj


return {
  "Wansmer/treesj",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  cmd = {
    "TSJToggle",
    "TSJSplit",
    "TSJJoin",
  },
  keys = {
    {
      "<leader>s",
      function()
        return require("treesj").split()
      end,
      desc = "Split long lines with treesj"
    },
    {
      "<leader>j",
      function()
        return require("treesj").join()
      end,
      desc = "Join long lines with treesj"
    },
  },

  opts = {
    use_default_keymaps = false,
  }
}
