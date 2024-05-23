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
      "<leader>lc",
      function()
        return vim.lsp.buf.code_action()
      end,
      desc = "Get code actions",
    },
    {
      "<leader>lc",
      function()
        return vim.lsp.buf.code_action({
          options = {
            range = vim.lsp.util.make_range_params().range,
          },
        })
      end,
      mode = "v",
      desc = "Get range code actions",
    },
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
        return vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end,
      desc = "Toggle inlay hints",
    },
    {
      "<leader>ls",
      function()
        return vim.lsp.buf.signature_help()
      end,
      desc = "Show signature help",
    },
    {
      "<leader>ln",
      function()
        return vim.lsp.buf.rename()
      end,
      desc = "Rename",
    },
  },

  config = function()
    require("_.tools"):update_lsp()
    vim.lsp.inlay_hint.enable(true)
  end,
}
