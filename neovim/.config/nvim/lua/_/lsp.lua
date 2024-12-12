-- different LSP helpers

local M = {
  data = {},
}

function M:set(server_name, opts)
  self.data[server_name] = opts or {}
end

return M
