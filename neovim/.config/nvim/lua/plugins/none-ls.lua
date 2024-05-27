-- none-ls
-- https://github.com/nvimtools/none-ls.nvim

return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvimtools/none-ls-extras.nvim",
  },
  event = { "FileType" },

  config = function()
    require("null-ls").setup({
      sources = require("_.none-ls"):init(),
    })
  end,
}
