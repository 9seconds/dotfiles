-- niceties for folds
-- https://github.com/anuvyklack/pretty-fold.nvim


return {
  "anuvyklack/pretty-fold.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter"
  },
  event = "VeryLazy",

  config = function()
    vim.o.foldmethod= "expr"
    vim.o.foldexpr = "nvim_treesitter#foldexpr()"
    -- this is required because folding is recalculated
    -- so we have to unfold everything again
    vim.cmd("normal zR")

    require("pretty-fold").setup({})
  end
}
