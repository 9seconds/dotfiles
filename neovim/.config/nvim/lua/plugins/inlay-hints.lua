-- LSP inlay hints support
-- https://github.com/lvimuser/lsp-inlayhints.nvim

return {
  "lvimuser/lsp-inlayhints.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
  },
  keys = {
    {
      "<leader>li",
      function()
        require("lsp-inlayhints").toggle()
      end,
      desc = "Toggle inlay hints",
    },
  },
  event = { "VeryLazy" },

  config = function()
    local mod = require("lsp-inlayhints")

    mod.setup({})

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("9_InlayHints", {}),
      callback = function(args)
        if args.data and args.data.client_id then
          mod.on_attach(vim.lsp.get_client_by_id(args.data.client_id), args.buf)
        end
      end,
    })
  end,
}
