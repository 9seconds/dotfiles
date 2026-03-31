-- https://github.com/bash-lsp/bash-language-server
-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/bashls.lua

return {
  cmd = {
    "bash-language-server",
    "start",
  },
  filetypes = {
    "bash",
    "shell",
    "sh",
  },
}
