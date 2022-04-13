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


M.get_git_config = (function()
  local job = require("plenary.job")

  local cache = {}

  return function()
    local gitdir = ""
    local cwd = vim.fn.getcwd()
    local cachekey = cwd

    if vim.b.gitsigns_status_dict then
      gitdir = vim.b.gitsigns_status_dict.gitdir
      cachekey = gitdir
    end

    if cache[cachekey] then
      return cache[cachekey]
    end

    local args = {"-P"}
    if gitdir then
      table.insert(args, "--git-dir")
      table.insert(args, gitdir)
    end
    table.insert(args, "config")
    table.insert(args, "--list")

    local cmd = job:new({
      command="git",
      args=args,
      cwd=cwd,
      enable_recording=true,
    })

    local stdout, code = cmd:sync()
    if code ~= 0 then
      return {}
    end

    local config = {}

    for _, line in ipairs(stdout) do
      local chunks = vim.split(line, "=", {plain=true, trimempty=true})
      config[chunks[1]] = table.concat(vim.list_slice(chunks, 2), "=")
    end

    cache[cachekey] = config

    return config
  end
end)()


return M
