-- sensible folding
-- https://github.com/kevinhwang91/nvim-ufo

return {
  "kevinhwang91/nvim-ufo",
  version = "*",
  dependencies = {
    "kevinhwang91/promise-async",
    "nvim-treesitter/nvim-treesitter",
  },
  event = "VeryLazy",

  init = function()
    vim.o.foldcolumn = "4"
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
  end,

  config = function()
    local ufo = require("ufo")

    vim.keymap.set("n", "zR", ufo.openAllFolds, {
      desc = "Open all folds",
    })
    vim.keymap.set("n", "zM", ufo.closeAllFolds, {
      desc = "Close all folds",
    })

    ufo.setup({
      provider_selector = function()
        return {
          "treesitter",
          "indent",
        }
      end,
    })
  end,
}
