local M = {}


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
