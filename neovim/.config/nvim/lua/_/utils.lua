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

function M.get_buf_file_size(bufnr)
  bufnr = bufnr or 0

  local buf_name = vim.api.nvim_buf_get_name(bufnr)
  if not buf_name then
    return 0
  end

  local stat = vim.uv.fs_stat(buf_name, nil)
  if not stat then
    return 0
  end

  return stat.size
end

return M
