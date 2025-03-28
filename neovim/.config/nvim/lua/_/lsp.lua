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
  vim.g.lsp_configs = {}

  vim.lsp.inlay_hint.enable(false)
  vim.lsp.enable({
    "bash-language-server",
    "basedpyright",
    "lua-language-server",
  })

  vim.api.nvim_create_autocmd("FileType", {
    once = true,
    callback = function()
      require("mini.icons").tweak_lsp_kind()

      vim.lsp.config("*", {
        root_markers = { ".git" },
        capabilities = require("blink.cmp").get_lsp_capabilities({
          textDocument = {
            completion = {
              completionItem = {
                snippetSupport = false,
              },
            },
            semanticTokens = {
              multilineTokenSupport = true,
            },
          },
        }),
      })
    end,
  })
end

setup()

return M
