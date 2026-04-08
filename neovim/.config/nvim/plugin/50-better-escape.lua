-- hacks around escape
-- https://github.com/max397574/better-escape.nvim

require("_.pack").add(
  "https://github.com/max397574/better-escape.nvim",
  vim.version.range("*"),
  function()
    require("better_escape").setup({
      default_mappings = false,
    })
  end,
  "InsertEnter"
)
