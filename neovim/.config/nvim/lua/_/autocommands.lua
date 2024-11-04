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

  -- disable all LSPs for help
  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("9_Help", {}),
    pattern = "help",
    callback = function()
      for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
        vim.lsp.buf_detach_client(0, client.id)
      end

      vim.keymap.set("n", "<C-]>", "<cmd>help <C-r><C-w><CR>", {
        buffer = 0,
        noremap = true,
        silent = true,
      })
    end,
  })
end

setup()
