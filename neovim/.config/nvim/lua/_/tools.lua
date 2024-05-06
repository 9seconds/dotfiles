-- different LSP helpers

local M = {
  configs = {
    lsp = {
      opts = {},
      changed = {},
    },
    formatters = {
      filetypes = {},
      settings = {},
    },
    linters = {
      filetypes = {},
      settings = {},
    },
  },
}

function M:lsp(server_name, opts)
  local lsp = self.configs.lsp

  lsp.opts[server_name] = opts or {}
  lsp.changed[server_name] = true
end

function M:update_lsp()
  local lsp = self.configs.lsp

  if vim.tbl_count(lsp.changed) == 0 then
    return
  end

  local nvim_lsp = require("cmp_nvim_lsp")
  local lspconfig = require("lspconfig")

  local active_clients = {}
  for _, v in ipairs(vim.lsp.get_clients()) do
    active_clients[v.name] = v
  end

  local capabilities = vim.tbl_extend(
    "force",
    vim.lsp.protocol.make_client_capabilities(),
    nvim_lsp.default_capabilities()
  )
  -- see https://github.com/neovim/neovim/issues/23291
  capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

  for name, opts in pairs(lsp.opts) do
    opts = vim.tbl_extend("force", { capabilities = capabilities }, opts or {})

    local conf = lspconfig[name]
    local current_client = active_clients[name]

    if current_client == nil then
      conf.setup(opts)
    elseif lsp.changed[name] and opts.settings then
      current_client.notify(
        "workspace/didChangeConfiguration",
        { settings = opts.settings }
      )
    end

    lsp.changed[name] = nil
  end

  vim.cmd("LspStart")
end

function M:fmt(name, filetypes, opts)
  local fmts = self.configs.formatters

  fmts.settings[name] =
    vim.tbl_deep_extend("force", fmts.settings[name] or {}, opts or {})

  for _, value in ipairs(filetypes or {}) do
    if fmts.filetypes[value] == nil then
      fmts.filetypes[value] = {}
    end
    table.insert(fmts.filetypes[value], name)
  end
end

function M:lint(name, filetypes, opts)
  local lnt = self.configs.linters

  lnt.settings[name] =
    vim.tbl_deep_extend("force", lnt.settings[name] or {}, opts or {})

  for _, value in ipairs(filetypes or {}) do
    if lnt.filetypes[value] == nil then
      lnt.filetypes[value] = {}
    end
    table.insert(lnt.filetypes[value], name)
  end
end

return M
