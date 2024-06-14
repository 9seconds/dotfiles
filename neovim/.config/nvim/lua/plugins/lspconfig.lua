-- lsp configuration
-- https://github.com/neovim/nvim-lspconfig

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "hrsh7th/cmp-nvim-lsp",
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
      mode = { "n", "v" },
      desc = "Format",
    },
  },

  config = function()
    require("_.lsp"):update()
    vim.lsp.inlay_hint.enable(false)
  end,
}
