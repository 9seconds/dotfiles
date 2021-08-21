-- vim: ts=2:sw=2:sts=2

local M = {}


-- perform a correct deep merge of several maps
function M.tbl_merge(self, ...)
  return vim.tbl_deep_extend("force", ...)
end


-- this function sets a global key mapping
function M.keymap(self, mode, lhs, rhs, options)
  return vim.api.nvim_set_keymap(
    mode,
    lhs,
    rhs,
    self:tbl_merge({silent=true}, options or {})
  )
end


-- this function sets a global key mapping with noremap=true
function M.keynmap(self, mode, lhs, rhs, options)
  return self:keymap(mode, lhs, rhs, {noremap=true})
end


-- this function sets a global key mapping with expr=true
function M.keyemap(self, mode, lhs, rhs, options)
  return self:keymap(mode, lhs, rhs, {expr=true})
end


-- returns another function that sets a key mapping to a buffer
function M.get_buf_keymap(self, bufnr, defaults)
  defaults = self:tbl_merge({silent=true}, defaults or {})

  return function(mode, lhs, rhs, options)
    return vim.api.nvim_buf_set_keymap(
      bufnr,
      mode,
      lhs,
      rhs,
      self:tbl_merge(defaults or {}, options or {})
    )
  end
end


-- returns another function that sets an option to a buffer
function M.get_buf_set_option(self, bufnr)
  return function(key, value)
    vim.api.nvim_buf_set_option(bufnr, key, value)
  end
end

-- returns internal representation of terminal code or keycodes.
-- please see :h nvim_replace_termcodes() for details.
function M.termcode(self, code)
  return vim.api.nvim_replace_termcodes(code, true, true, true)
end


function M.set_indent(self, tbl, options)
  if type(options) == "number" then
    options = {tabstop=options}
  end

  options.tabstop = options.tabstop or 4
  tbl.tabstop = options.tabstop
  tbl.softtabstop = options.softtabstop or options.tabstop
  tbl.shiftwidth = options.shiftwidth or options.tabstop
end


return M
