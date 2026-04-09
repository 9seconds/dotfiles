require("_.lint").set({
  python = { "ruff" },
  lua = { "selene" },
})

vim.lsp.enable({
  "basedpyright",
  "bash-language-server",
  "lua-language-server",
  "typos-lsp",
})
