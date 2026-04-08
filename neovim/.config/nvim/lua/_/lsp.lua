-- different LSP helpers

local function enable(server_name)
  vim.schedule(function()
    vim.lsp.enable(server_name)
  end)
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
end

return {
  enable = enable,
  setup = setup,
}
