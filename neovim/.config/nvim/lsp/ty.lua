-- https://docs.astral.sh/ty/editors/#neovim
-- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/ty.lua

return {
  cmd = { "ty", "server" },
  filetypes = { "python" },
  root_markers = { "setup.cfg", "pyproject.toml", ".git" },
}
