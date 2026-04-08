-- bracketed movements
-- https://github.com/nvim-mini/mini.bracketed

require("_.pack").add({
  url = "https://github.com/nvim-mini/mini.bracketed",
  releases = true,
  lazy = {"BufRead", "BufNew"},
  config = function()
    require("mini.bracketed").setup()
  end
})
