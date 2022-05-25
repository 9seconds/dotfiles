local M = {
  servers={},
  null_ls={
    code_actions={},
    diagnostics={},
    formattings={},
    hovers={},
    completions={},
    customs={}
  }
}

-- this function is executed when LSP attaches to a buffer.
local function on_attach(client, bufnr)
  local utils = require("_utils")

  local set_option = utils:get_buf_set_option(bufnr)
  local keymap = utils:get_buf_keymap(bufnr, {noremap=true})

  set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  if client.server_capabilities.codeActionProvider then
    keymap("n", "<leader>fc", "<cmd>lua require('telescope.builtin').lsp_code_actions()<cr>")
    keymap("v", "<leader>fc", "<cmd>lua require('telescope.builtin).lsp_range_code_actions()<cr>")
  end

  if client.server_capabilities.definitionProvider then
    keymap("n", "<c-]>", "<cmd>lua require('telescope.builtin').lsp_definitions()<cr>")
  end

  if client.server_capabilities.documentFormattingProvider then
    keymap("n", "<leader>f=", "<cmd>lua vim.lsp.buf.formatting()<cr>")
  end

  if client.server_capabilities.documentRangeFormattingProvider then
    keymap("v", "<leader>f=", "<cmd>lua vim.lsp.buf.range_formatting()<cr>")
  end

  if client.server_capabilities.hoverProvider then
    keymap("n", "<leader>fh", "<cmd>lua vim.lsp.buf.hover()<cr>")
  end

  if client.server_capabilities.referencesProvider then
    keymap(
      "n", "<leader>fr",
      "<cmd>lua require('telescope.builtin').lsp_references()<cr>"
    )
  end

  if client.server_capabilities.documentSymbolProvider then
    keymap(
      "n", "<leader>fd",
      "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>"
    )
  end

  if client.server_capabilities.signatureHelpProvider then
    keymap("n", "<leader>fs", "<cmd>lua vim.lsp.buf.signature_help()<cr>")
  end

  if client.server_capabilities.renameProvider then
    keymap("n", "<leader>fn", "<cmd>lua vim.lsp.buf.rename()<cr>")
  end
end


-- add/modify config
function M.configure_server(self, name, config)
  self.servers[name] = config
end


-- add/modify null ls source
function M.null_ls_set_code_action(self, name, config)
  self.null_ls.code_actions[name] = config
end


-- add/modify null ls diagnostic
function M.null_ls_set_diagnostic(self, name, config)
  self.null_ls.diagnostics[name] = config
end


-- add/modify null ls diagnostic
function M.null_ls_set_formatting(self, name, config)
  self.null_ls.formattings[name] = config
end


-- add/modify null ls hovers
function M.null_ls_set_hover(self, name, config)
  self.null_ls.hovers[name] = config
end


-- add/modify null ls completions
function M.null_ls_set_hover(self, name, config)
  self.null_ls.completions[name] = config
end


-- add/modify null ls custom server definition
function M.null_ls_set_custom(self, name, config)
  self.null_ls.customs[name] = config
end


-- do setup lsp
function M.setup(self)
  local lsp_installer = require("nvim-lsp-installer")
  local null_ls = require("null-ls")

  lsp_installer.on_server_ready(function(server)
    local utils = require("_utils")
    local opts = utils:tbl_merge(
      {
        on_attach=on_attach,
        flags={
          debounce_text_changes=100,
        },
      },
      self.servers[server.name] or {}
    )

    server:setup(opts)
  end)

  local null_ls_sources = {}

  for k, v in pairs(self.null_ls.code_actions) do
    table.insert(null_ls_sources, null_ls.builtins.code_actions[k].with(v))
  end

  for k, v in pairs(self.null_ls.diagnostics) do
    table.insert(null_ls_sources, null_ls.builtins.diagnostics[k].with(v))
  end

  for k, v in pairs(self.null_ls.formattings) do
    table.insert(null_ls_sources, null_ls.builtins.formatting[k].with(v))
  end

  for k, v in pairs(self.null_ls.hovers) do
    table.insert(null_ls_sources, null_ls.builtins.hover[k].with(v))
  end

  for k, v in pairs(self.null_ls.completions) do
    table.insert(null_ls_sources, null_ls.builtins.completion[k].with(v))
  end

  for k, v in pairs(self.null_ls.customs) do
    null_ls.register(v)
  end

  null_ls.setup({
    sources=null_ls_sources
  })
end

return M
