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

  -- disable mini.pairs for prompts
  vim.api.nvim_create_autocmd("BufEnter", {
    group = vim.api.nvim_create_augroup("9_MiniPairs", {}),
    callback = function()
      if vim.bo.buftype == "prompt" then
        vim.b.minipairs_disable = true
      end
    end,
  })
end

setup()
