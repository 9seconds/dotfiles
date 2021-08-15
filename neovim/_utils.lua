-- vim: ts=2:sw=2:sts=2

local M = {}


-- makes a default key options for mappings
local function make_keymap_opts(options)
  local opts = {
    noremap=true,
    silent=true,
  }

  for k, v in pairs(options or {}) do
    opts[k] = v
  end

  return opts
end

-- this function sets a global key mapping
function M.keymap(mode, lhs, rhs, options)
  vim.api.nvim_set_keymap(mode, lhs, rhs, make_keymap_opts(options))
end

-- returns another function that sets a key mapping to a buffer
function M.get_buf_keymap(bufnr)
  return function(mode, lhs, rhs, options)
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, make_keymap_opts(options))
  end
end

-- returns another function that sets an option to a buffer
function M.get_buf_set_option(bufnr)
  return function(key, value)
    vim.api.nvim_buf_set_option(bufnr, key, value)
  end
end

-- returns internal representation of terminal code or keycodes.
-- please see :h nvim_replace_termcodes() for details.
function M.termcode(code)
  return vim.api.nvim_replace_termcodes(code, true, true, true)
end


return M
