-- custom pipeline tha sources .nvim.lua files starting from the root
-- a better exrc because allows to open project file in a random directory

local M = {
  loaded = {},
}

function M:react(path)
  local dirname = vim.fs.dirname(path)
  local read = false

  if dirname ~= path then
    read = self:react(dirname) or read
  end

  local exrc_path = vim.fs.joinpath(path, ".nvim.lua")
  if self.loaded[exrc_path] then
    return read
  end
  self.loaded[exrc_path] = true

  local stat = vim.uv.fs_stat(exrc_path)
  if not stat then
    return read
  end

  if not vim.secure.read(exrc_path) then
    return read
  end

  if xpcall(vim.cmd.source, debug.traceback, exrc_path) then
    return true
  end

  vim.api.nvim_notify(
    string.format("Cannot load %s exrc", exrc_path),
    vim.log.levels.WARN,
    {}
  )

  return false
end

function M.setup()
  vim.o.exrc = false

  local dir_changed = vim.schedule_wrap(function()
    if M:react(vim.uv.cwd()) then
      vim.api.nvim_exec_autocmds("User", {
        pattern = "_9ExrcUpdated",
      })
    end
  end)

  local root = vim.fs.root(vim.env.PWD, {
    ".editorconfig",
    ".git",
    "Makefile",
    "package.json",
    "pyproject.toml",
  })
  if root and root ~= vim.uv.cwd() then
    vim.fn.chdir(root)
  end

  vim.api.nvim_create_autocmd({ "DirChanged" }, {
    group = vim.api.nvim_create_augroup("9_Exrc", {}),
    callback = dir_changed,
  })

  dir_changed()
end

return M
