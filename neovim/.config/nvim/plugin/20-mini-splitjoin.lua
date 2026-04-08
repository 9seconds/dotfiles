-- better splitjoin
-- https://github.com/nvim-mini/mini.splitjoin

require("_.pack").add(
  "https://github.com/nvim-mini/mini.splitjoin",
  vim.version.range("*"),
  function()
    require("mini.splitjoin").setup({
      mappings = {
        toggle = "<leader>j",
      },
    })
  end,
  true
)
