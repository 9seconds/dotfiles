-- autofocus
-- https://github.com/nvim-focus/focus.nvim


local ignore_filetypes = {
  "neo-tree",
}
local ignore_buftypes = {
  "nofile",
  "prompt",
  "popup",
}


return {
  "nvim-focus/focus.nvim",
  version = "*",
  event = "VeryLazy",

  config = function()
    require("focus").setup({})

    local augroup = vim.api.nvim_create_augroup("9_Focus", {})

    vim.api.nvim_create_autocmd("WinEnter", {
      group = augroup,
      callback = function()
        if vim.tbl_contains(ignore_buftypes, vim.bo.buftype) then
          vim.b.focus_disable = true
        end
      end,
      desc = "Disable focus autoresize for BufType",
    })

    vim.api.nvim_create_autocmd("FileType", {
      group = augroup,
      callback = function()
        if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
          vim.b.focus_disable = true
        end
      end,
      desc = "Disable focus autoresize for FileType",
    })
  end
}
