-- surround plugin
-- github.com/kylechui/nvim-surround

return {
  "kylechui/nvim-surround",
  version = "*",
  event = "VeryLazy",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-treesitter/nvim-treesitter-textobjects",
  },

  opts = {},
}
