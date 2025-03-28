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

  vim.api.nvim_create_autocmd("FileType", {
    once = true,
    callback = function ()
      vim.lsp.config("*", {
        root_markers = { ".git" },
        capabilities = require("blink.cmp").get_lsp_capabilities({
          textDocument = {
            completion = {
              completionItem = {
                snippetSupport = false,
              },
            },
          },
        }),
      })
    end
  })

  vim.lsp.enable({
    "basedpyright",
    "bash-language-server",
    "lua-language-server",
  })
end

setup()

return M
