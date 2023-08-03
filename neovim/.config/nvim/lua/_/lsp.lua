-- different LSP helpers


local function on_attach(client, bufnr)
  local function keymap(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, {buffer = bufnr})
  end

  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  keymap("n", "<leader>lc", vim.lsp.buf.code_action)
  keymap("v", "<leader>lc", function()
    vim.lsp.buf.code_action({
      options = {
        range = vim.lsp.util.make_range_params().range
      }
    })
  end)

  keymap("n", "<c-]>", function()
    require('telescope.builtin').lsp_definitions()
  end)

  keymap("n", "<leader>l=", vim.lsp.buf.format)
  keymap("v", "<leader>l=", function()
    vim.lsp.buf.format({
      options = {
        range = vim.lsp.util.make_range_params().range
      }
    })
  end)

  keymap("n", "<leader>lr", function()
    require('telescope.builtin').lsp_references()
  end)

  keymap("n", "<leader>ld", function()
    require('telescope.builtin').lsp_document_symbols()
  end)

  keymap("n", "<leader>lh", vim.lsp.buf.hover)
  keymap("n", "<leader>ls", vim.lsp.buf.signature_help)
  keymap("n", "<leader>ln", vim.lsp.buf.rename)
end


return function()
  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  return {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
