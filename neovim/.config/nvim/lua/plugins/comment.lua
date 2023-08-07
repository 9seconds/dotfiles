-- commentary plugin
-- https://github.com/numToStr/Comment.nvim


return {
  "numToStr/Comment.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  version = "*",
  event = "VeryLazy",

  config = function()
    local commentstring = require("ts_context_commentstring.integrations.comment_nvim")

    require('Comment').setup({
      pre_hook=commentstring.create_pre_hook(),
    })
  end
}
