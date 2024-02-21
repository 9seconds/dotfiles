-- lsp configuration
-- https://github.com/neovim/nvim-lspconfig

local max_file_size = 120 * 1024 -- 100 kilobytes

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  event = {
    "Filetype",
  },

  config = function()
    local lspconfig = require("lspconfig")
    local nvim_lsp = require("cmp_nvim_lsp")
    local tools = require("_.tools")
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

        keymap("n", "<leader>lh", vim.lsp.buf.hover, "Show hover")
        keymap(
          "n",
          "<leader>ls",
          vim.lsp.buf.signature_help,
          "Show signature help"
        )
        keymap("n", "<leader>ln", vim.lsp.buf.rename, "Rename")
      end,
    })

    for name, opts in pairs(tools.configs.lsp) do
      local capabilities = vim.tbl_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        nvim_lsp.default_capabilities()
      )
      -- see https://github.com/neovim/neovim/issues/23291
      capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

      do
        local conf = lspconfig[name]
        conf.setup(
          vim.tbl_extend("force", { capabilities = capabilities }, opts or {})
        )

        -- local try_add = conf.manager.try_add
        -- conf.manager.try_add = function(self, bufnr)
        --   if utils.get_buf_file_size(bufnr) < max_file_size then
        --     return try_add(self, bufnr)
        --   end
        -- end
      end
    end
  end,
}
