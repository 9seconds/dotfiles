local M = {}


local function memoized(cache_key_func, func)
  local cache = {}

  return function(...)
    local cachekey = cache_key_func(...)

    if not cache[cachekey] then
      cache[cachekey] = func(...)
    end

    return cache[cachekey]
  end
end


local function git_cache_key_func()
  if vim.b.gitsigns_status_dict then
    return vim.b.gitsigns_status_dict.gitdir
  end

  return vim.fn.getcwd()
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


M.git_config = memoized(
  git_cache_key_func,
  function()
    local stdout, code = M.git({"config", "--list"})

    if code ~= 0 then
      return {}
    end

    local config = {}

    for _, line in ipairs(stdout) do
      local line_chunks = vim.split(line, "=", {plain=true, trimempty=true})
      local name_chunks = vim.split(
        line_chunks[1] or "",
        ".",
        {plain=true, trimempty=true})
      local current_config = config

      for i = 1, #name_chunks-1 do
        if not current_config[name_chunks[i]] then
          current_config[name_chunks[i]] = {}
        end
        current_config = current_config[name_chunks[i]]
      end

      current_config[name_chunks[#name_chunks]] = table.concat(
        vim.list_slice(line_chunks, 2), "=")
    end

    return config
  end
)


return M
