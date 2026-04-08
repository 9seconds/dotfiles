-- keyboard hints
-- https://github.com/nvim-mini/mini.clue

require("_.pack").add(
  "https://github.com/nvim-mini/mini.clue",
  vim.version.range("*"),
  function()
    require("mini.clue").setup()
  end,
  true
)
