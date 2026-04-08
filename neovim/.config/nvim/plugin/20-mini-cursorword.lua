-- show a word under cursor
-- https://github.com/nvim-mini/mini.cursorword

require("_.pack").add(
  "https://github.com/nvim-mini/mini.cursorword",
  vim.version.range("*"),
  function()
    require("mini.cursorword").setup()
  end,
  {"BufRead", "BufNew"}
)
