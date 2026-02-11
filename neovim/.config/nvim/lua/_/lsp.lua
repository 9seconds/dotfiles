-- different LSP helpers

local M = {}

function M.define(server_name, opts)
  if vim.g.lsp_configs[server_name] == false then
    return {}
  end

  return vim.tbl_deep_extend(
    "force",
    opts,
    vim.g.lsp_configs[server_name] or {}
  )
end

local function setup()
  vim.lsp.inlay_hint.enable(false)

  vim.lsp.config("*", {
    root_markers = { ".git" },
    capabilities = {
      textDocument = {
        completion = {
          completionItem = {
            snippetSupport = false,
          },
        },
      },
    },
  })

  vim.lsp.enable({
    "basedpyright",
    "bash-language-server",
    "lua-language-server",
    "typos-lsp",
    "gopls",
  })
end

setup()

return M
