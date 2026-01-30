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
  event = "WinNew",

  keys = {
    {
      "<leader>sl",
      function()
        require("focus").split_command("l")
      end,
      desc = "Focus: Split to the right",
    },
    {
      "<leader>sk",
      function()
        require("focus").split_command("k")
      end,
      desc = "Focus: Split up",
    },
    {
      "<leader>sj",
      function()
        require("focus").split_command("j")
      end,
      desc = "Focus: Split down",
    },
    {
      "<leader>sh",
      function()
        require("focus").split_command("h")
      end,
      desc = "Focus: Split left",
    },
  },

  opts = {
    commands = false,
    autoresize = {
      minwidth = 80,
      minheight = 10,
      focusedwindow_minwidth = 160,
      focusedwindow_minheight = 20,
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
