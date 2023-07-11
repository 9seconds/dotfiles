-- structural search/replace
-- https://github.com/cshuaimin/ssr.nvim


return {
  "cshuaimin/ssr.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },

  keys = {
    {
      "<leader>sR",
      function()
        require("ssr").open()
      end,
      mode = { "n", "x" },
      desc = "Structural Replace",
    },
  },
}
