-- lsp configuration
-- https://github.com/neovim/nvim-lspconfig

local KEYS = {
  -- references
  ["grr"] = {
    mode = "n",
    action = function()
      return require("telescope.builtin").lsp_references()
    end,
    opts = {
      desc = "LSP: Show references",
    },
  },

  -- document symbols in current document
  ["gO"] = {
    mode = "n",
    action = function()
      return require("telescope.builtin").lsp_document_symbols()
    end,
    opts = {
      desc = "LSP: Document symbols in current document",
    },
  },

  -- document workspace
  ["gW"] = {
    mode = "n",
    action = function()
      return require("telescope.builtin").lsp_workspace_symbols()
    end,
    opts = {
      desc = "LSP: Document symbols in current workspace",
    },
  },

  -- inlay hints
  ["grh"] = {
    mode = "n",
    action = function()
      return vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
    end,
    opts = {
      desc = "LSP: Toggle inlay hints",
    },
  },

  -- implementations
  ["gri"] = {
    mode = "n",
    action = function()
      return require("telescope.builtin").lsp_implementations()
    end,
    opts = {
      desc = "LSP: Show implementations",
    },
  },
}

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "echasnovski/mini.icons",
    "Saghen/blink.cmp",
  },
  event = {
    "Filetype",
  },

  config = function()
    vim.lsp.inlay_hint.enable(false)

    local lspconfig = require("lspconfig")
    local configs = require("_.lsp")

    require("mini.icons").tweak_lsp_kind()

    for name, opts in pairs(configs.data) do
      local conf = lspconfig[name]
      conf.capabilities = require("blink.cmp").get_lsp_capabilities({
        textDocument = {
          completion = {
            completionItem = {
              snippetSupport = false,
            },
          },
        },
      })
      conf.setup(opts)
    end

    local group = vim.api.nvim_create_augroup("9_LSP", {})

    vim.api.nvim_create_autocmd("LspAttach", {
      group = group,
      callback = function(args)
        if vim.tbl_count(vim.lsp.get_clients({ bufnr = args.buf })) > 1 then
          return
        end

        for key, key_opts in pairs(KEYS) do
          local opts =
            vim.tbl_extend("force", key_opts.opts or {}, { buffer = true })
          vim.keymap.set(key_opts.mode, key, key_opts.action, opts)
        end
      end,
    })
    vim.api.nvim_create_autocmd("LspDetach", {
      group = group,
      callback = function(args)
        if not vim.tbl_isempty(vim.lsp.get_clients({ bufnr = args.buf })) then
          return
        end

        for key, key_opts in pairs(KEYS) do
          vim.keymap.del(key_opts.mode, key, { buffer = true })
        end
      end,
    })
  end,
}
