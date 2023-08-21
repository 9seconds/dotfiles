-- This module contains user commands

local M = {}

function M.setup()
  if vim.fn.executable("rg") then
    vim.o.grepprg = "rg --vimgrep --follow --trim --smart-case --color never"
  elseif vim.fn.executable("ag") then
    vim.o.grepprg = "ag --vimgrep --nocolor --follow --smart-case"
  end

  vim.cmd("command! -nargs=+ -complete=file Grep noautocmd grep! <args> | redraw! | copen")
  vim.cmd("command! -nargs=+ -complete=file LGrep noautocmd lgrep! <args> | redraw! | lopen")
end

return M
