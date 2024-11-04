-- lsp configuration
-- https://github.com/neovim/nvim-lspconfig

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  event = {
    "Filetype",
  },
  keys = {
    {
      "<c-]>",
      function()
        return require("telescope.builtin").lsp_definitions()
      end,
      desc = "Go to definition",
    },
    {
      "<leader>lr",
      function()
        return require("telescope.builtin").lsp_references()
      end,
      desc = "Show references",
    },
    {
      "<leader>ld",
      function()
        return require("telescope.builtin").lsp_document_symbols()
      end,
      desc = "Show document symbols",
    },
    {
      "<leader>lt",
      function()
        return vim.lsp.buf.type_definition()
      end,
      desc = "Show types",
    },
    {
      "<leader>lh",
      function()
        return vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
      end,
      desc = "Toggle inlay hints",
    },
    {
      "<leader>lf",
      function()
        return vim.lsp.buf.format()
      end,
      desc = "Format",
    },
    {
      "<leader>ls",
      function()
        return vim.lsp.buf.signature_help()
      end,
      mode = { "n", "i" },
      desc = "Signature help",
    },
  },

  init = function()
    vim.lsp.inlay_hint.enable(false)
  end,

  config = function()
    vim.g.lspconfig = true
    require("_.lsp"):update()
  end,
}
