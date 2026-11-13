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

function M.keymap(plugin, key_prefix, global_opts)
  global_opts = vim.tbl_extend("force", {
    noremap = true,
    silent = true,
  }, global_opts or {}
  )

  key_prefix = key_prefix or ""

  plugin = plugin or ""
  if plugin ~= "" then
    plugin = plugin .. ": "
  end

  return function (description, key, callback, mode, opts)
    opts = vim.tbl_extend("force", global_opts, opts or {})
    opts.desc = plugin .. description

    vim.keymap.set(mode or "n", key_prefix .. key, callback, opts)
  end
end

return M
