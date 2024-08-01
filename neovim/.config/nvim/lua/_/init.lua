-- custom pipeline tha sources .nvim.lua files starting from the root
-- a better exrc because allows to open project file in a random directory

local function setup_settings()
  vim.o.exrc = false
  -- lazy.nvim required mapleader to be present before its execution
  vim.g.mapleader = " "
  vim.g.maplocalleader = " "
end

local function setup_project_root()
  local root = vim.fs.root(vim.env.PWD, {
    ".git",
    ".editorconfig",
    "Makefile",
    "package.json",
    "pyproject.toml",
    "go.mod",
  })

  if root and root ~= vim.uv.cwd() then
    vim.fn.chdir(root)
  end
end

local function setup_project_settings(root)
  local dirname = vim.fs.dirname(root)
  if dirname ~= root then
    setup_project_settings(dirname)
  end

  local exrc_path = vim.fs.joinpath(root, ".nvim.lua")
  if not vim.uv.fs_stat(exrc_path) then
    return
  end

  if not vim.secure.read(exrc_path) then
    return
  end

  if not xpcall(vim.cmd.source, debug.traceback, exrc_path) then
    vim.api.nvim_notify(
      string.format("Cannot load %s exrc", exrc_path),
      vim.log.levels.WARN,
      {}
    )
  end
end

local function setup()
  setup_settings()
  setup_project_root()
  setup_project_settings(vim.uv.cwd())
end

setup()
