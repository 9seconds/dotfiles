-- different LSP helpers

vim.lsp.inlay_hint.enable(false)

vim.lsp.config("*", {
  root_markers = { ".git" },
  capabilities = {
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = false,
        },
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
      disableOrganizeImports = true,
      openFilesOnly = true,
      analysis = {
        diagnosticMode = "openFilesOnly",
        typeCheckingMode = "off",
        inlayHints = {
          variableTypes = true,
          callArgumentNames = true,
          functionReturnTypes = true,
          genericTypes = true,
        },
      },
    },
  },
})

vim.lsp.config("gopls", {
  settings = {
    gopls = {
      semanticTokens = true,
      gofumpt = vim.fn.executable("gofumpt") == 1,
    },
  },
})

vim.lsp.config("typos_lsp", {
  init_options = {
    config = os.getenv("TYPOS_CONFIG_PATH"),
    diagnosticSeverity = "Hint",
  },
})

vim.api.nvim_create_autocmd("FileType", {
  once = true,
  callback = function()
    vim.lsp.enable({
      "basedpyright",
      "bash-language-server",
      "docker-language-server",
      "emmylua_ls",
      "typos_lsp",
    })
  end,
})
