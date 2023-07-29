-- This module contains different autocommands and autogroups


return {
  setup = function()
    -- resize panes on window resize
    local augroup_resize_panes = vim.api.nvim_create_augroup("9_ResizePanes", {})
    vim.api.nvim_create_autocmd("VimResized", {
      group=augroup_resize_panes,
      command="normal <c-w>="
    })

    -- delete trailing whitespaces
    local augroup_strip_traling_whitespaces = vim.api.nvim_create_augroup(
      "9_StripTrailingWhitespaces", {})
    vim.api.nvim_create_autocmd("BufWritePre", {
      group=augroup_strip_traling_whitespaces,
      callback=function()
        local save = vim.fn.winsaveview()
        vim.cmd [[%s/\s\+$//e]]
        vim.fn.winrestview(save)
      end
    })

    local augroup_unfold = vim.api.nvim_create_augroup("9_Unfold", {})
    vim.api.nvim_create_autocmd("BufWinEnter", {
      group=augroup_unfold,
      command="normal zR"
    })
  end
}
