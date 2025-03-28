-- https://github.com/bash-lsp/bash-language-server
-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/bashls.lua

return require("_.lsp").define("bash-language-server", {
  cmd = {
    "bash-language-server",
    "start",
  },
  filetypes = {
    "bash",
    "shell",
    "sh",
  },
})
