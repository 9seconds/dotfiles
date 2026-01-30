-- better autoresizing
-- https://github.com/nvim-focus/focus.nvim

local ignore_buftypes = {
  "nofile",
  "popup",
  "prompt",
  "terminal",
}

local ignore_filetypes = {}

return {
  "nvim-focus/focus.nvim",
  version = "*",
  event = "VeryLazy",

  opts = {
    commands = false,
    autoresize = {
      minwidth = 40,
      minheight = 10,
      focusedwindow_minwidth = 120,
      focusedwindow_minheight = 30,
      height_quickfix = 10,
    },
  },

  config = function(_, opts)
    require("focus").setup(opts)

    vim.api.nvim_create_autocmd("WinEnter", {
      group = vim.api.nvim_create_augroup("9_Focus", {}),
      callback = function()
        vim.w.focus_disable = (
          vim.list_contains(ignore_buftypes, vim.bo.buftype)
          or vim.list_contains(ignore_filetypes, vim.bo.filetype)
        )
      end,
    })
  end,
}
