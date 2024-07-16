-- different LSP helpers

local M = {
  data = {
    opts = {},
    changed = {},
  },
}

function M:set(server_name, opts)
  self.data.opts[server_name] = opts or {}
  self.data.changed[server_name] = true
end

function M:update()
  if vim.tbl_count(self.data.changed) == 0 then
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

  for name, opts in pairs(self.data.opts) do
    opts = vim.tbl_extend("force", { capabilities = capabilities }, opts or {})

    local conf = lspconfig[name]
    local current_client = active_clients[name]

    if current_client == nil then
      conf.setup(opts)
    elseif self.data.changed[name] and opts.settings then
      current_client.notify(
        "workspace/didChangeConfiguration",
        { settings = opts.settings }
      )
    end

    self.data.changed[name] = nil
  end

  vim.cmd("LspStart")
end

return M
