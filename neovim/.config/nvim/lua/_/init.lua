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
  opts = vim.tbl_extend("keep", opts or {}, require("_.lsp")())
  require("lspconfig")[server_name].setup(opts)
end


return M
