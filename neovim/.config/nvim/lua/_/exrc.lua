-- custom pipeline tha sources .nvim.lua files starting from the root
-- a better exrc because allows to open project file in a random directory

local M = {
  loaded = {},
}

function M:react(path)
  local dirname = vim.fs.dirname(path)
  if dirname ~= path then
    self:react(dirname)
  end

  local exrc_path = vim.fs.joinpath(path, ".nvim.lua")
  if self.loaded[exrc_path] then
    return
  end
  self.loaded[exrc_path] = true

  local stat = vim.uv.fs_stat(exrc_path)
  if not stat then
    return
  end

  if not vim.secure.read(exrc_path) then
    return
  end

  local ok = xpcall(vim.cmd.source, debug.traceback, exrc_path)
  if not ok then
    vim.api.nvim_notify(
      string.format("Cannot load %s exrc", exrc_path),
      vim.log.levels.WARN,
      {}
    )
  end
end

function M.setup()
  vim.o.exrc = false

  local callback = vim.schedule_wrap(function()
    M:react(vim.uv.cwd())

    if vim.g.lspconfig then
      require("_.lsp"):update()
    end
  end)

  vim.api.nvim_create_autocmd({ "DirChanged" }, {
    group = vim.api.nvim_create_augroup("9_ExRC", {}),
    callback = callback,
  })

  callback()
end

return M
