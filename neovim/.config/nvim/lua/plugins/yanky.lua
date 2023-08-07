-- yank-ring
-- https://github.com/gbprod/yanky.nvim

return {
  "gbprod/yanky.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  version = "*",
  keys = {
    {
      "<leader>ty",
      function()
        return require("telescope").extensions.yank_history.yank_history()
      end,
      desc = "Get yank history"
    },
    {
      "p", "<Plug>(YankyPutAfter)",
      mode = {"n", "x"}
    },
    {
      "P", "<Plug>(YankyPutBefore)",
      mode = {"n", "x"}
    },
    {
      "gp", "<Plug>(YankyGPutAfter)",
      mode = {"n", "x"}
    },
    {
      "gP", "<Plug>(YankyGPutBefore)",
      mode = {"n", "x"}
    },
    {
      "y", "<Plug>(YankyYank)",
      mode = {"n", "x"}
    },
    {"<c-n>", "<Plug>(YankyCycleForward)"},
    {"<c-p>", "<Plug>(YankyCycleBackward)"},
  },

  config = function()
    require("yanky").setup({})
    require("telescope").load_extension("yank_history")
  end
}
