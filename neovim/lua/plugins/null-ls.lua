-- null-ls settings
-- github.com/jose-elias-alvarez/null-ls.nvim

return {
  "jose-elias-alvarez/null-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "jay-babu/mason-null-ls.nvim",
      version = "*",
      dependencies = {
        "williamboman/mason.nvim",
      },

      opts = {
        ensure_installed = {
          "jq",
          "editorconfig-checker",
          "hadolint",
          "gitlint",
          "yamllint",
          "markdownlint",
          "prettier",
          "shellcheck"
        }
      }
    }
  },
  event = "VeryLazy",

  config = function()
    local null_ls = require("null-ls")

    local sources = {
      null_ls.builtins.completion.spell,
      null_ls.builtins.hover.printenv,
      null_ls.builtins.completion.tags,
      null_ls.builtins.formatting.jq,
      null_ls.builtins.diagnostics.editorconfig_checker,
      null_ls.builtins.diagnostics.gitlint,
      null_ls.builtins.diagnostics.hadolint,
      null_ls.builtins.diagnostics.markdownlint,
      null_ls.builtins.formatting.prettier,
      null_ls.builtins.code_actions.shellcheck,
      null_ls.builtins.diagnostics.shellcheck
    }

    if vim.fn.executable("fish") then
      table.insert(sources, null_ls.builtins.diagnostics.fish)
      table.insert(sources, null_ls.builtins.formatting.fish_indent)
    end

    null_ls.setup({
      sources = sources,
      on_attach = require("_.lsp")().on_attach,
    })
  end
}
