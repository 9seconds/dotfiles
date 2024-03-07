-- show context
-- https://github.com/nvim-treesitter/nvim-treesitter-context

return {
  "nvim-treesitter/nvim-treesitter-context",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  cmd = {
    "TSContextEnable",
    "TSContextDisable",
    "TSContextToggle",
  },
  keys = {
    {
      "<leader>C",
      "<cmd>TSContextToggle<cr>",
      desc = "Show treesitter context",
    },
  },

  config = function()
    require("treesitter-context").setup({
      enable = true,
      line_numbers = false,
    })
  end,
}
