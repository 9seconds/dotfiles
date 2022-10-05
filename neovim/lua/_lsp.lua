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
  local navic = require("nvim-navic")

  navic.attach(client, bufnr)

  local function keymap(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, {buffer=bufnr})
  end

  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  keymap("n", "<leader>fc", vim.lsp.buf.code_action)
  keymap("v", "<leader>fc", function()
    vim.lsp.buf.code_action({
      options={
        range=vim.lsp.util.make_range_params().range
      }
    })
  end)

  keymap("n", "<c-]>", function()
    require('telescope.builtin').lsp_definitions()
  end)

  keymap("n", "<leader>f=", vim.lsp.buf.format)
  keymap("v", "<leader>f=", function()
    vim.lsp.buf.format({
      options={
        range=vim.lsp.util.make_range_params().range
      }
    })
  end)


  keymap("n", "<leader>fr", function()
    require('telescope.builtin').lsp_references()
  end)

  keymap("n", "<leader>fd", function()
    require('telescope.builtin').lsp_document_symbols()
  end)

  keymap("n", "<leader>fh", vim.lsp.buf.hover)
  keymap("n", "<leader>fs", vim.lsp.buf.signature_help)
  keymap("n", "<leader>fn", vim.lsp.buf.rename)
end


-- add/modify config
function M.configure_server(self, name, config)
  self.servers[name] = config or {}
end


-- add/modify null ls source
function M.null_ls_set_code_action(self, name, config)
  self.null_ls.code_actions[name] = config or {}
end


-- add/modify null ls diagnostic
function M.null_ls_set_diagnostic(self, name, config)
  self.null_ls.diagnostics[name] = config or {}
end


-- add/modify null ls diagnostic
function M.null_ls_set_formatting(self, name, config)
  self.null_ls.formattings[name] = config or {}
end


-- add/modify null ls hovers
function M.null_ls_set_hover(self, name, config)
  self.null_ls.hovers[name] = config or {}
end


-- add/modify null ls completions
function M.null_ls_set_hover(self, name, config)
  self.null_ls.completions[name] = config or {}
end


-- add/modify null ls custom server definition
function M.null_ls_set_custom(self, name, config)
  self.null_ls.customs[name] = config or {}
end


-- do setup lsp
function M.setup(self)
  local lsp_installer = require("nvim-lsp-installer")
  local null_ls = require("null-ls")

  lsp_installer.on_server_ready(function(server)
    local opts = vim.tbl_deep_extend(
      "force",
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

  local function add(source, config)
    if config ~= nil then
      source = source.with(config)
    end
    table.insert(null_ls_sources, source)
  end

  for k, v in pairs(self.null_ls.code_actions) do
    add(null_ls.builtins.code_actions[k], v)
  end

  for k, v in pairs(self.null_ls.diagnostics) do
    add(null_ls.builtins.diagnostics[k], v)
  end

  for k, v in pairs(self.null_ls.formattings) do
    add(null_ls.builtins.formatting[k], v)
  end

  for k, v in pairs(self.null_ls.hovers) do
    add(null_ls.builtins.hover[k], v)
  end

  for k, v in pairs(self.null_ls.completions) do
    add(null_ls.builtins.completion[k], v)
  end

  for k, v in pairs(self.null_ls.customs) do
    null_ls.register(v)
  end

  null_ls.setup({
    sources=null_ls_sources
  })
end

return M
