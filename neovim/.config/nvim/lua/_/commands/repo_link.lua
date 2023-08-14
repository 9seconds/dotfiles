-- this module contains a basic fast implementation of linker to a specific place
-- in a remote git repository, createing an HTTP permalink
-- This is not a plugin but more like a fast ad-hoc solution implemented in a very
-- fast fashion, assuming that some 3pp plugins are present.


local M = {
  url_builders = {}
}


local get_remote_url = (function()
  local cache = {}
  local plenary_jobs = require("plenary.job")

  return function(root, name)
    if cache[root] then
      return cache[root]
    end

    local proc = plenary_jobs:new({
      command = "git",
      args = {
        "-P",
        "--git-dir", root,
        "remote", "get-url", name
      },
      enable_recording = true,
    })
    local stdout, code = proc:sync()

    if code ~= 0 then
      return ""
    end

    cache[root] = stdout[1]

    return stdout[1]
  end
end)()


local function parse_ssh(url)
  local host, user, project = string.match(
    url,
    "^git@([^:]+):([^/]+)/(.-)%.git"
  )

  if host ~= "" and user ~= "" and project ~= "" then
    return {
      host = host,
      user = user,
      project = project,
    }
  end
end


local function parse_https(url)
  local host, user, project = string.match(
    url,
    "^https?://([^/]+)/([^/]+)/(.-)%.git"
  )

  if host ~= "" and user ~= "" and project ~= "" then
    return {
      host = host,
      user = user,
      project = project,
    }
  end
end


function M.build_url_github(args)
  local anchor = "L" .. tostring(args.start_line)
  if args.start_line ~= args.end_line then
    anchor = anchor .. "-L" .. tostring(args.end_line)
  end

  return string.format(
    "https://github.com/%s/%s/blob/%s/%s#%s",
    args.user,
    args.project,
    args.reference,
    args.path,
    anchor)
end


function M.build_url_bitbucket(repo, ref, path, start_line, end_line)
  local anchor = "lines-" .. tostring(args.start_line)
  if args.start_line ~= args.end_line then
    anchor = anchor .. ":" .. tostring(args.end_line)
  end

  return string.format(
    "https://bitbucket.org/%s/%s/src/%s/%s#%s",
    args.user,
    args.project,
    args.reference,
    args.path,
    anchor)
end


function M.build_url_gitlab(repo, ref, path, start_line, end_line)
  local anchor = "L" .. tostring(args.start_line)
  if args.start_line ~= args.end_line then
    anchor = anchor .. "-" .. tostring(args.end_line)
  end

  return string.format(
    "https://gitlab.com/%s/%s/-/blob/%s/%s#%s",
    args.user,
    args.project,
    args.reference,
    args.path,
    anchor)
end


M.url_builders = {
  ["github.com"] = M.build_url_github,
  ["bitbucket.org"] = M.build_url_bitbucket,
  ["gitlab.com"] = M.build_url_gitlab,
}


function M.setup(builders)
  M.url_builders = vim.tbl_extend("force", M.url_builders, builders or {})
end


function M.make(opts)
  if vim.tbl_isempty(M.url_builders) then
    M.setup()
  end

  if not vim.b.gitsigns_status_dict then
    -- if gitsigns is not initialized, do nothing
    return
  end

  local current_path = vim.uv.fs_realpath(vim.api.nvim_buf_get_name(0))
  if not current_path then
    -- if not a file, also nothing to do here
    return
  end
  current_path = string.sub(current_path, 2 + #vim.b.gitsigns_status_dict.root)

  local root = vim.b.gitsigns_status_dict.gitdir
  local head = vim.b.gitsigns_status_dict.head
  local git_url = get_remote_url(root, opts.repo)

  parsed = parse_ssh(git_url)
  if not parsed then
    parsed = parse_https(git_url)
  end

  if not parsed then
    -- strange url format
    return
  end

  handler = M.url_builders[parsed.host]
  if not handler then
    -- unknown host
    return
  end

  vim.notify(handler({
    user = parsed.user,
    project = parsed.project,
    reference = head,
    path = current_path,
    start_line = opts.start_line,
    end_line = opts.end_line,
  }))
end


return M
