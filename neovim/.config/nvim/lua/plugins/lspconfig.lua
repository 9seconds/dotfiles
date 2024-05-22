-- lsp configuration
-- https://github.com/neovim/nvim-lspconfig

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  event = {
    "Filetype",
  },

  config = function()
    local utils = require("_.utils")

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("_9_LSP", {}),
      callback = function(ev)
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        local function keymap(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { desc = desc, buffer = ev.buf })
        end

        keymap("n", "<leader>lc", vim.lsp.buf.code_action, "Get code actions")
        keymap("v", "<leader>lc", function()
          vim.lsp.buf.code_action({
            options = {
              range = vim.lsp.util.make_range_params().range,
            },
          }, "Get range code actions")
        end)

        keymap("n", "<c-]>", function()
          require("telescope.builtin").lsp_definitions()
        end, "Go to LSP definitions")

        keymap("n", "<leader>lr", function()
          require("telescope.builtin").lsp_references()
        end, "Get references")

        keymap("n", "<leader>ld", function()
          require("telescope.builtin").lsp_document_symbols()
        end, "List document symbols")

        keymap("n", "<leader>lh", function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end, "Toggle inlay hints")

        keymap(
          "n",
          "<leader>ls",
          vim.lsp.buf.signature_help,
          "Show signature help"
        )
        keymap("n", "<leader>ln", vim.lsp.buf.rename, "Rename")
      end,
    })

    require("_.tools"):update_lsp()
    vim.lsp.inlay_hint.enable(true)
  end,
}
