-- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/gopls.lua

return require("_.lsp").define("gopls", {
  cmd = {
    "gopls",
  },
  filetypes = {
    "go",
    "gomod",
    "gowork",
    "gotmpl",
  },
})
