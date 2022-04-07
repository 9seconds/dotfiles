local ts_utils = require("nvim-treesitter.ts_utils")


local M = {}


local _get_ts_scope_at_cursor_by_bufnr = ts_utils.memoize_by_buf_tick(function(bufnr)
  local ts_locals = require("nvim-treesitter.locals")

  local cursor_node = ts_utils.get_node_at_cursor()

  return ts_locals.get_scope_tree(cursor_node, bufnr)
end)


-- this function trims spaces before and after the content body
function M.trim_space(text)
  return text:gsub("^%s+", ""):gsub("%s+$", "")
end


-- this function concatenates multiline text in a way so it removes all
-- prefixes whatsoever
function M.concat_multiline(tbl)
  return table.concat(vim.tbl_map(M.trim_space, tbl), " ")
end


-- this function returns a current treesitter scope under a cursor
function M.get_ts_scope_at_cursor()
  return _get_ts_scope_at_cursor_by_bufnr(vim.api.nvim_get_current_buf())
end


return M
