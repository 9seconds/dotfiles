-- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/gopls.lua

return {
  cmd = {
    "gopls",
  },
  filetypes = {
    "go",
    "gomod",
    "gowork",
    "gotmpl",
  },
  settings = {
    gopls = {
      semanticTokens = true,
      gofumpt = vim.fn.executable("gofumpt") == 1,
    },
  },
}
