-- show a word under cursor
-- https://github.com/nvim-mini/mini.cursorword

require("_.pack").add({
  url = "https://github.com/nvim-mini/mini.cursorword",
  releases = true,
  lazy = {"BufRead", "BufNew"},
  config = function()
    require("mini.cursorword").setup()
  end,
})
