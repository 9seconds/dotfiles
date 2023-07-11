-- This module contains various utils

local M = {}


function M.set_indent(length, obj)
  if obj == nil then
    obj = vim.o
  end

  -- tab length
  -- https://neovim.io/doc/user/options.html#'tabstop'
  obj.tabstop = length

  -- tab length on editing operations
  -- https://neovim.io/doc/user/options.html#'softtabstop'
  obj.softtabstop = length

  -- used for autoindent
  -- https://neovim.io/doc/user/options.html#'shiftwidth'
  obj.shiftwidth = length
end


return M
