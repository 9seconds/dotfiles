-- different LSP helpers

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
end

setup()
