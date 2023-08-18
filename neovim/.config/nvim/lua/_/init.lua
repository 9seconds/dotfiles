-- initialize settings

local M = {}

function M.setup()
  require("_.keymappings").setup()
  require("_.options").setup()
  require("_.autocommands").setup()
  require("_.commands").setup()
  require("_.terminal").setup()
end

function M.lsp(server_name, opts)
  local lsp = require("_.lsp")

  require("lspconfig")[server_name].setup(lsp.make_setup(opts))
end

return M
