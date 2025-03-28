-- https://docs.basedpyright.com/latest/
-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/basedpyright.lua

return require("_.lsp").define("basedpyright", {
  cmd = {
    "basedpyright-langserver",
    "--stdio",
  },

  filetypes = {
    "python",
  },

  handlers = {
    ["textDocument/publishDiagnostics"] = function() end,
  },

  settings = {
    basedpyright = {
      disableOrganizeImports = true,
      openFilesOnly = true,
      analysis = {
        diagnosticMode = "openFilesOnly",
        typeCheckingMode = "off",
        inlayHints = {
          variableTypes = true,
          callArgumentNames = true,
          functionReturnTypes = true,
          genericTypes = true,
        },
      },
    },
  },
})
