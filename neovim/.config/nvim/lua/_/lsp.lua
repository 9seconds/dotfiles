-- different LSP helpers

local has_harper = vim.fn.executable("harper-ls") == 1

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

vim.lsp.config("gopls", {
  settings = {
    gopls = {
      semanticTokens = true,
      gofumpt = vim.fn.executable("gofumpt") == 1,
    },
  },
})

vim.lsp.config("harper_ls", {
  settings = {
    ["harper-ls"] = {
      -- https://writewithharper.com/docs/rules
      linters = {
        ["LongSentences"] = false,
      }
    }
  }
})

vim.api.nvim_create_autocmd("FileType", {
  once = true,
  callback = function ()
    vim.lsp.enable({
      "bash-language-server",
      "docker-language-server",
      "emmylua_ls",
    })

    if has_harper then
      vim.lsp.enable({ "harper_ls" })
    end
  end,
})
