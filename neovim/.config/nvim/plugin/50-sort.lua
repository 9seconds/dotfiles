-- sort enhancements
-- https://github.com/sQVe/sort.nvim

require("_.pack").add(
  "https://github.com/sQVe/sort.nvim",
  vim.version.range("*"),
  function()
    require("sort").setup()
  end,
  true
)
