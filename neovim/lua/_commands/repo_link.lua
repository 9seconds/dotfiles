local function get_remotes()
  local utils = require("_utils")

  local remotes = {}
  for name, conf in pairs(utils.git_config().remote or {}) do
    table.insert(remotes, {
      name=name,
      url=conf.url or "",
    })
  end

  return remotes
end


local function generate_link_for_github(url, branch, path, start_line, finish_line)
  local stripped_url = vim.split(url, ":", {plain=true, trimempty=true})[2] or ""
  local chunks = vim.split(stripped_url, "/", {plain=true, trimempty=true})
  local username = chunks[1] or ""
  local repo = chunks[2] or ""

  if vim.endswith(repo, ".git") then
    repo = repo:sub(1, #repo-#".git")
  end

  local anchor = "L" .. tostring(start_line)
  if start_line ~= finish_line then
    anchor = anchor .. "-L" .. tostring(finish_line)
  end

  return string.format(
    "https://github.com/%s/%s/blob/%s/%s#%s",
    username,
    repo,
    branch,
    path,
    anchor)
end


local function generate_link_for_bitbucket(url, branch, path, start_line, finish_line)
  local stripped_url = vim.split(url, ":", {plain=true, trimempty=true})[2] or ""
  local chunks = vim.split(stripped_url, "/", {plain=true, trimempty=true})
  local username = chunks[1] or ""
  local repo = chunks[2] or ""

  if vim.endswith(repo, ".git") then
    repo = repo:sub(1, #repo-#".git")
  end

  local anchor = "lines-" .. tostring(start_line)
  if start_line ~= finish_line then
    anchor = anchor .. ":" .. tostring(finish_line)
  end

  return string.format(
    "https://bitbucket.org/%s/%s/src/%s/%s#%s",
    username,
    repo,
    branch,
    path,
    anchor)
end


local function generate_link_for_gitlab(url, branch, path, start_line, finish_line)
  local stripped_url = vim.split(url, ":", {plain=true, trimempty=true})[2] or ""
  local chunks = vim.split(stripped_url, "/", {plain=true, trimempty=true})
  local username = chunks[1] or ""
  local repo = chunks[2] or ""

  if vim.endswith(repo, ".git") then
    repo = repo:sub(1, #repo-#".git")
  end

  local anchor = "L" .. tostring(start_line)
  if start_line ~= finish_line then
    anchor = anchor .. "-" .. tostring(finish_line)
  end

  return string.format(
    "https://gitlab.com/%s/%s/-/blob/%s/%s#%s",
    username,
    repo,
    branch,
    path,
    anchor)
end


local function generate_link(url, start_line, finish_line)
  local plenary_strings = require("plenary.strings")

  if not vim.b.gitsigns_status_dict then
    return ""
  end

  local branch = vim.b.gitsigns_status_dict.head
  local root = vim.b.gitsigns_status_dict.root

  local current_path = vim.fn.resolve(vim.api.nvim_buf_get_name(0))
  if not current_path then
    return ""
  end

  current_path = plenary_strings.strcharpart(current_path, 1 + root:len())

  if url:find("bitbucket.org") then
    url = generate_link_for_bitbucket(url, branch, current_path, start_line, finish_line)
  elseif url:find("github.com") then
    url = generate_link_for_github(url, branch, current_path, start_line, finish_line)
  elseif url:find("gitlab.com") then
    url = generate_link_for_gitlab(url, branch, current_path, start_line, finish_line)
  else
    url = ""
  end

  vim.notify(url)
end


return function(args)
  local remotes = get_remotes()

  if #remotes == 0 then
    return
  elseif #remotes == 1 then
    generate_link(remotes[1].url, args.line1, args.line2)
  else
    vim.ui.select(remotes, {
      prompt="Select repo:",
      format_item=function(item)
        return item.name
      end
    }, function(choice)
      generate_link(choice.url, args.line1, args.line2)
    end)
  end
end
