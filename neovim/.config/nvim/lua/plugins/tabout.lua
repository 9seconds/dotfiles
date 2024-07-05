-- tab to escape pairs
-- https://github.com/abecodes/tabout.nvim

return {
  "abecodes/tabout.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "hrsh7th/nvim-cmp",
  },
  event = "InsertEnter",

  opts = {},
}
