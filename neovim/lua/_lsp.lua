local M = {
  server_configs={}
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

-- add/modify config
function M.configure_server(self, name, config)
  self.server_configs[name] = config
end

-- do setup lsp
function M.setup(self)
  local lsp_installer = require("nvim-lsp-installer")

  lsp_installer.on_server_ready(function(server)
    local utils = require("_utils")
    local opts = utils:tbl_merge(
      {
        on_attach=on_attach,
        flags={
          debounce_text_changes=100,
        },
      },
      self.server_configs[server.name] or {}
    )

    server:setup(opts)
  end)
end

return M
