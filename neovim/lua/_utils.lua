local M = {}


-- perform a correct deep merge of several maps
function M.tbl_merge(self, ...)
  return vim.tbl_deep_extend("force", ...)
end


-- returns internal representation of terminal code or keycodes.
-- please see :h nvim_replace_termcodes() for details.
function M.termcode(self, code)
  return vim.api.nvim_replace_termcodes(code, true, true, true)
end


-- sets a consistent indentation settings
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
