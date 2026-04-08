-- autopairing
-- https://github.com/nvim-mini/mini.pairs

require("_.pack").add(
  "https://github.com/nvim-mini/mini.pairs",
  vim.version.range("*"),
  function()
    require("mini.pairs").setup()
  end,
  "InsertCharPre"
)
