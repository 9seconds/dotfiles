-- markdown rendering
-- https://github.com/OXY2DEV/markview.nvim

return {
  "OXY2DEV/markview.nvim",
  version = "*",
  lazy = false,

  opts = {
    preview = {
      filetypes = {
        "markdown",
        "codecompanion",
      },
      ignore_buftypes = {},
    },
  },
}
