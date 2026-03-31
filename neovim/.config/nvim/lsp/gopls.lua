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
}
