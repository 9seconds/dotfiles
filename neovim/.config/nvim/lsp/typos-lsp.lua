-- https://github.com/crate-ci/typos
-- https://github.com/tekumara/typos-lsp
-- https://github.com/crate-ci/typos/blob/master/docs/reference.md
-- https://github.com/tekumara/typos-lsp/blob/main/docs/neovim-lsp-config.md
-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/typos_lsp.lua

return require("_.lsp").define("typos-lsp", {
  cmd = {
    "typos-lsp",
  },
  init_options = {
    config = os.getenv("TYPOS_CONFIG_PATH"),
    diagnosticSeverity = "Hint",
  },
})
