-- autopairing
-- https://github.com/nvim-mini/mini.pairs

require("_.pack").add({
  url = "https://github.com/nvim-mini/mini.pairs",
  releases = true,
  lazy = "InsertCharPre",
  config = function()
    require("mini.pairs").setup()
  end,
})
