require("_.lint").set({
  python = { "ruff" },
  lua = { "selene" },
})

vim.lsp.config("emmylua_ls", {
  cmd = {"emmylua_ls", "--editor", "neovim"},
  -- https://mintlify.wiki/EmmyLuaLs/emmylua-analyzer-rust/editor-setup#neovim-configuration-for-plugin-development
  settings = {
    emmylua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = {"vim"},
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
    },
  },
})

vim.lsp.enable({
  "basedpyright",
  "bash-language-server",
  "typos-lsp",
  "emmylua_ls",
  "ty",
})
