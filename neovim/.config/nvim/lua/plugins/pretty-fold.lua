-- niceties for folds
-- https://github.com/anuvyklack/pretty-fold.nvim


return {
  "anuvyklack/pretty-fold.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter"
  },

  config = function()
    vim.o.foldmethod= "expr"
    vim.o.foldexpr = "nvim_treesitter#foldexpr()"

    require("pretty-fold").setup({})
  end
}
