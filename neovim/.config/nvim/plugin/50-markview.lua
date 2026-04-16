-- better markdown rendering
-- https://github.com/OXY2DEV/markview.nvim

vim.pack.add({
  {
    src = "https://github.com/OXY2DEV/markview.nvim",
    version = vim.version.range("*"),
  },
})

require("markview").setup({
  preview = {
    icon_provider = "mini",
    ignore_buftypes = {},
  },
})
