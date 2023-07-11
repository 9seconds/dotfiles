-- different LSP helpers


local function on_attach(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
      require("nvim-navic").attach(client, bufnr)
  end

  require("lsp_signature").on_attach({
    bind = true,
    hint_prefix = "💡 ",
    handler_opts = {
      border = "rounded"
    }
  }, bufnr)

  local function keymap(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, {buffer = bufnr})
  end

  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  keymap("n", "<leader>yc", vim.lsp.buf.code_action)
  keymap("v", "<leader>yc", function()
    vim.lsp.buf.code_action({
      options = {
        range = vim.lsp.util.make_range_params().range
      }
    })
  end)

  keymap("n", "<c-]>", function()
    require('telescope.builtin').lsp_definitions()
  end)

  keymap("n", "<leader>y=", vim.lsp.buf.format)
  keymap("v", "<leader>y=", function()
    vim.lsp.buf.format({
      options = {
        range = vim.lsp.util.make_range_params().range
      }
    })
  end)

  keymap("n", "<leader>yr", function()
    require('telescope.builtin').lsp_references()
  end)

  keymap("n", "<leader>yd", function()
    require('telescope.builtin').lsp_document_symbols()
  end)

  keymap("n", "<leader>yh", function()
    print("!!!")
    vim.lsp.buf.hover()
  end)
  keymap("n", "<leader>ys", vim.lsp.buf.signature_help)
  keymap("n", "<leader>yn", vim.lsp.buf.rename)
end


return function()
  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  return {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
