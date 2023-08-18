-- structural search/replace
-- https://github.com/cshuaimin/ssr.nvim

return {
  "cshuaimin/ssr.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },

  keys = {
    {
      "<leader>r",
      function()
        require("ssr").open()
      end,
      mode = { "n", "x" },
      desc = "Structural Replace",
    },
  },
}
