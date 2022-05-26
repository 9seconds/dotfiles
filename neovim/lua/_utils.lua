local M = {}


-- return a memoized version of func where key is generated by cache_key_func
-- both function accept the same list of arguments.
function M.memoized(cache_key_func, func)
  local cache = {}

  return function(...)
    local cachekey = cache_key_func(...)

    if not cache[cachekey] then
      cache[cachekey] = func(...)
    end

    return cache[cachekey]
  end
end


-- execute git binary
function M.git(args)
  local job = require("plenary.job")

  local cmd_args = {"-P"}  -- no pager
  if vim.b.gitsigns_status_dict then
    table.insert(cmd_args, "--git-dir")
    table.insert(cmd_args, vim.b.gitsigns_status_dict.gitdir)
  end

  for _, v in ipairs(args) do
    table.insert(cmd_args, v)
  end

  local cmd = job:new({
    command="git",
    args=cmd_args,
    cwd=vim.fn.getcwd(),
    enable_recording=true,
  })
  local stdout, code = cmd:sync()

  if code ~= 0 then
    stdout = {}
  end

  return stdout, code
end


return M
