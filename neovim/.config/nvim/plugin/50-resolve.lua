-- conflict resolver
-- https://github.com/spacedentist/resolve.nvim

require("_.pack").add({
  url = "https://github.com/spacedentist/resolve.nvim",
  lazy = {"BufRead", "BufNew"},
  config = function()
    require("resolve").setup({})
  end
})
