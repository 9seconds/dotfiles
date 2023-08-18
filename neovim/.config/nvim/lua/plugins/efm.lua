-- configuration for efm
-- https://github.com/creativenull/efmls-configs-nvim

return {
  "creativenull/efmls-configs-nvim",
  version = "*",
  dependencies = {
    "neovim/nvim-lspconfig",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },

  config = function()
    local efmls = require("efmls-configs")
    local lsp = require("_.lsp")

    efmls.init({
      on_attach = lsp.on_attach,
      init_options = {
        documentFormatting = true,
      },
    })
  end,
}
