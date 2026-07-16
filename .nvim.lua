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

vim.lsp.config("basedpyright", {
  handlers = {
    ["textDocument/publishDiagnostics"] = function() end,
  },
  settings = {
    basedpyright = {
      analysis = {
        pythonVersion = "3.10",
        pythonPlatform = "Linux",
        typeCheckingMode = "off",
        extraPaths = {
          "bin/.local/share/9seconds/pythonpath"
        },
      }
    },
  },
})

vim.lsp.enable({
  "basedpyright",
  "bash-language-server",
  "emmylua_ls",
  "ruff",
  "ty",
  "typos-lsp",
})
