-- icons
-- https://github.com/nvim-mini/mini.icons

require("_.pack").add(
  "https://github.com/nvim-mini/mini.icons",
  vim.version.range("*"),
  function()
    require("mini.icons").setup()
  end,
  true
)
