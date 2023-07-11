-- tab to escape pairs
-- https://github.com/abecodes/tabout.nvim


return {
  "abecodes/tabout.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  event = "InsertEnter",

  opts = {
    enable_backwards = false
  }
}
