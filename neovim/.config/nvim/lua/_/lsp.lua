-- different LSP helpers

local M = {}

function M.on_attach(client, bufnr)
  local function keymap(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr })
  end

  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  keymap("n", "<leader>lc", vim.lsp.buf.code_action)
  keymap("v", "<leader>lc", function()
    vim.lsp.buf.code_action({
      options = {
        range = vim.lsp.util.make_range_params().range,
      },
    })
  end)

  keymap("n", "<c-]>", function()
    require("telescope.builtin").lsp_definitions()
  end)

  keymap("n", "<leader>l=", vim.lsp.buf.format)
  keymap("v", "<leader>l=", function()
    vim.lsp.buf.format({
      options = {
        range = vim.lsp.util.make_range_params().range,
      },
    })
  end)

  keymap("n", "<leader>lr", function()
    require("telescope.builtin").lsp_references()
  end)

  keymap("n", "<leader>ld", function()
    require("telescope.builtin").lsp_document_symbols()
  end)

  keymap("n", "<leader>lh", vim.lsp.buf.hover)
  keymap("n", "<leader>ls", vim.lsp.buf.signature_help)
  keymap("n", "<leader>ln", vim.lsp.buf.rename)
end

function M.setup(server_name, opts)
  local lspconfig = require("lspconfig")

  opts = opts or {}
  opts.on_attach = on_attach

  if not opts.capabilities then
    opts.capabilities = require("cmp_nvim_lsp").default_capabilities()
  end

  lspconfig[server_name].setup(opts)
end

function M.efm_setup(languages)
  local imported = {}
  local can_format = false

  for language, specs in pairs(languages) do
    imported[language] = {}

    for _, spec in ipairs(specs) do
      if spec[1] == nil then
        table.insert(imported[language], spec[2])
      else
        local ok, value = pcall(require, "efmls-configs.linters." .. spec[1])
        if not ok then
          ok, value = pcall(require, "efmls-configs.formatters." .. spec[1])
          can_format = can_format or ok
        end

        if ok then
          table.insert(
            imported[language],
            vim.tbl_deep_extend("force", value, spec[2] or {})
          )
        else
          vim.api.nvim_err_writeln(
            "cannot import " .. spec[1] .. " from efmls-configs"
          )
        end
      end
    end
  end

  M.setup("efm", {
    filetypes = vim.tbl_keys(imported),
    settings = {
      rootMarkers = { ".git/" },
      languages = imported,
    },
    init_options = {
      documentFormatting = can_format,
      documentRangeFormatting = can_format,
    },
  })
end

return M
