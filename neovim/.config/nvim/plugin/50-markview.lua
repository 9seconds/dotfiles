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
    filetypes = { "markdown", "codecompanion" },
    ignore_buftypes = {},
  },
})

-- codecompanion sets filetype AFTER displaying the buffer, so markview's
-- BufEnter/BufWinEnter fires too early and skips attachment.
-- Re-trigger attachment on FileType.
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("9_MarkView", {}),
  pattern = "codecompanion",
  callback = function(args)
    require("markview.actions").attach(args.buf)
  end,
})
