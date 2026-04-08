-- better splitjoin
-- https://github.com/nvim-mini/mini.splitjoin

require("_.pack").add({
  url = "https://github.com/nvim-mini/mini.splitjoin",
  releases = true,
  lazy = true,
  config = function()
    require("mini.splitjoin").setup({
      mappings = {
        toggle = "<leader>j",
      },
    })
  end,
})
