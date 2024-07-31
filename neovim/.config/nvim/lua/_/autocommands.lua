-- This module contains different autocommands and autogroups

local function setup()
  -- resize panes on window resize
  vim.api.nvim_create_autocmd("VimResized", {
    group = vim.api.nvim_create_augroup("9_ResizePanes", {}),
    command = "normal <c-w>=",
  })

  -- delete trailing whitespaces
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("9_StripTrailingWhitespaces", {}),
    callback = function()
      local save = vim.fn.winsaveview()
      vim.cmd([[%s/\s\+$//e]])
      vim.fn.winrestview(save)
    end,
  })
end

setup()
