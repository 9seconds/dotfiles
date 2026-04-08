-- bracketed movements
-- https://github.com/nvim-mini/mini.bracketed

require("_.pack").add(
  "https://github.com/nvim-mini/mini.bracketed",
  vim.version.range("*"),
  function()
    require("mini.bracketed").setup()
  end,
  {"BufRead", "BufNew"}
)
