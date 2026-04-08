-- sort enhancements
-- https://github.com/sQVe/sort.nvim

require("_.pack").add({
  url = "https://github.com/sQVe/sort.nvim",
  releases = true,
  lazy = true,
  config = function()
    require("sort").setup()
  end,
})
