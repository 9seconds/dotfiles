local M = {
  server_setups={},
}

-- this function is executed when LSP attaches to a buffer.
local function on_attach(client, bufnr)
  local utils = require("_utils")

  local set_option = utils:get_buf_set_option(bufnr)
  local keymap = utils:get_buf_keymap(bufnr, {noremap=true})

  set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  if client.resolved_capabilities.code_action then
    keymap("n", "<leader>yc", "<cmd>lua vim.lsp.buf.code_action()<cr>")
    keymap("v", "<leader>yc", "<cmd>lua vim.lsp.buf.range_code_action()<cr>")
  end

  if client.resolved_capabilities.goto_definition then
    keymap("n", "<c-]>", "<cmd>lua vim.lsp.buf.definition()<cr>")
  end

  if client.resolved_capabilities.document_formatting then
    keymap("n", "<leader>y=", "<cmd>lua vim.lsp.buf.formatting()<cr>")
  end

  if client.resolved_capabilities.document_range_formatting then
    keymap("v", "<leader>y=", "<cmd>lua vim.lsp.buf.range_formatting()<cr>")
  end

  if client.resolved_capabilities.hover then
    keymap("n", "<leader>yh", "<cmd>lua vim.lsp.buf.hover()<cr>")
  end

  if client.resolved_capabilities.find_references then
    keymap(
      "n", "<leader>fr",
      "<cmd>lua require('fzf-lua').lsp_references()<cr>"
    )
  end

  if client.resolved_capabilities.document_symbol then
    keymap(
      "n", "<leader>ft",
      "<cmd>lua require('fzf-lua').lsp_document_symbols()<cr>"
    )
  end

  if client.resolved_capabilities.signature_help then
    keymap("n", "<leader>ys", "<cmd>lua vim.lsp.buf.signature_help()<cr>")
  end

  if client.resolved_capabilities.rename then
    keymap("n", "<leader>yr", "<cmd>lua vim.lsp.buf.rename()<cr>")
  end
end


-- returns a table with all available servers (that were installed on
-- a disk)
function M.available_servers(self)
  local installed = {}
  local lspinstall = require("lspinstall")

  for _, server in pairs(lspinstall.installed_servers()) do
    installed[server] = true
  end

  return installed
end

-- returns a table with active servers (installed and requested)
function M.active_servers(self)
  local active = {}

  for server, _ in pairs(self:available_servers()) do
    active[server] = self.server_setups[server]
  end

  return active
end

-- generates a new config for LSP setup function
function M.new_server_config(self)
  return {
    on_attach=on_attach,
    flags={
      debounce_text_changes=100,
    }
  }
end

-- adds a new server to a list of used
function M.use_server(self, name, config)
  local utils = require("_utils")

  self.server_configs[name] = utils:tbl_merge(
    self:new_server_config(),
    config or {}
  )
end

-- do setup lsp
function M.setup(self)
  local lspconfig = require("lspconfig")
  local lspinstall = require("lspinstall")

  local function do_setup()
    lspinstall.setup()

    for server, config in pairs(self:active_servers()) do
      lspconfig[server].setup(config)
    end
  end

  function lspinstall.post_install_hook()
    do_setup()
    vim.cmd("bufdo e")
  end

  do_setup()
end


return M
