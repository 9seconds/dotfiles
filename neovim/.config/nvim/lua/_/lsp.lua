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

  local get_capabilities = require("blink.cmp").get_lsp_capabilities
  local lspconfig = require("lspconfig")

  local active_clients = {}
  for _, v in ipairs(vim.lsp.get_clients()) do
    active_clients[v.name] = v
  end

  for name, opts in pairs(self.data.opts) do
    local conf = lspconfig[name]
    local current_client = active_clients[name]
    conf.capabilities = get_capabilities(conf.capabilities)

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
