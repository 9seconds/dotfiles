-- vim: ts=2:sw=2:sts=2

local M = {
  server_configs={},
}

local utils = require("_utils")
local lspconfig = require("lspconfig")
local lspinstall = require("lspinstall")
local lspinstall_servers = require("lspinstall/servers")
local lspinstall_util = require("lspinstall/util")


-- this function is executed when LSP attaches to a buffer.
local function on_attach(client, bufnr)
  local set_option = utils.get_buf_set_option(bufnr)
  local keymap = utils.get_buf_keymap(bufnr)

  set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  keymap("n", "<leader>yd", "<cmd>lua vim.lsp.buf.definition()<cr>")
  keymap("n", "<leader>y=", "<cmd>lua vim.lsp.buf.formatting()<cr>")
  keymap("v", "<leader>y=", "<cmd>lua vim.lsp.buf.range_formatting()<cr>")
  keymap("n", "<leader>yh", "<cmd>lua vim.lsp.buf.hover()<cr>")
  keymap("n", "<leader>yr", "<cmd>lua vim.lsp.buf.references()<cr>")
  keymap("n", "<leader>yR", "<cmd>lua vim.lsp.buf.rename()<cr>")
  keymap("n", "<leader>yc", "<cmd>lua vim.lsp.buf.code_action()<cr>")
  keymap("v", "<leader>yc", "<cmd>lua vim.lsp.buf.range_code_action()<cr>")
  keymap("n", "<leader>ys", "<cmd>lua vim.lsp.buf.signature_help()<cr>")
end


-- returns a table with all available servers (that were installed on
-- a disk)
function M.available_servers(self)
  local installed = {}

  for _, server in pairs(lspinstall.installed_servers()) do
    installed[server] = true
  end

  return installed
end

-- returns a table with active servers (installed and requested)
function M.active_servers(self)
  local active = {}

  for server, _ in pairs(self:available_servers()) do
    active[server] = self.server_configs[server]
  end

  return active
end

-- generates a new config for LSP setup function
function M.new_server_config(self)
  return {
    on_attach=on_attach,
    capabilities=capabilities,
    flags={
      debounce_text_changes=100,
    }
  }
end

-- adds a new server to a list of used
function M.use_server(self, name, config)
  self.server_configs[name] = config or self:new_server_config()
end

-- defines how to manage a custom server
function M.define_custom_server(self, language, lsp_name, command, install_script, uninstall_script)
  local config = lspinstall_util.extract_config(lsp_name)

  config.default_config.cmd[1] = command
  lspinstall_servers[language] = vim.tbl_extend("error", config, {
    install_script=install_script or "",
    uninstall_script=uninstall_script or "rm -rf *"
  })
end

-- do setup lsp
function M.setup(self)
  local function do_setup()
    lspinstall.setup()

    for server, config in pairs(self:active_servers()) do
      lspconfig[server].setup(config)
    end
  end

  do_setup()
  lspinstall.post_install_hook = function()
    do_setup()
    vim.cmd("bufdo e")
  end
end


return M
