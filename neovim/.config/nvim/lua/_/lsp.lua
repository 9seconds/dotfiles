-- different LSP helpers

local M = {}

function M.define(server_name, opts)
  return vim.tbl_deep_extend(
    "force",
    opts,
    vim.g.lsp_configs[server_name] or {}
  )
end

function M.setup()
  vim.g.lsp_configs = {}

  vim.lsp.inlay_hint.enable(false)

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

return M
