-- different LSP helpers

local function enable(server_name)
  vim.schedule(function()
    vim.lsp.enable(server_name)
  end)
end

local function define(server_name, opts)
  vim.lsp.config(server_name, opts)
  enable(server_name)
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
  define = define,
  enable = enable,
  setup = setup,
}
