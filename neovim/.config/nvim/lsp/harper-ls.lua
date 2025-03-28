-- https://writewithharper.com
-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/harper_ls.lua

return require("_.lsp").define("harper-ls", {
  cmd = {
    "harper-ls",
    "--stdio",
  },

  filetypes = {
    "c",
    "cpp",
    "cs",
    "gitcommit",
    "go",
    "html",
    "java",
    "javascript",
    "lua",
    "markdown",
    "nix",
    "python",
    "ruby",
    "rust",
    "swift",
    "toml",
    "typescript",
    "typescriptreact",
    "haskell",
    "cmake",
    "typst",
    "php",
    "dart",
  },

  settings = {
    markdown = {
      dialect = "American",
    },
  },
})
