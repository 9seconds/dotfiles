-- different LSP helpers

local M = {}


function M.on_attach(client, bufnr)
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


function M.efm_config(opts)
  local conf = {}

  for language, linters in pairs(opts) do
    local lang_config = {}

    for _, linter in ipairs(linters) do
      if not linter[1] then
        table.insert(lang_config, linter[2])
      else
        local ok, entity = pcall(require, "efmls-configs.linters." .. linter[1])

        if not ok then
          entity = require("efmls-configs.formatters." .. linter[1])
        end

        table.insert(
          lang_config,
          vim.tbl_deep_extend("force", entity, linter[2] or {})
        )
      end
    end

    conf[language] = {
      linter = lang_config
    }
  end

  return conf
end


function M.setup(server_name, opts)
  if server_name == "efm" then
    return require("efmls-configs").setup(opts)
  end

  local lspconfig = require("lspconfig")

  opts = opts or {}
  opts.on_attach = on_attach

  if not opts.capabilities then
    opts.capabilities = require("cmp_nvim_lsp").default_capabilities()
  end

  lspconfig[server_name].setup(opts)
end


return M
