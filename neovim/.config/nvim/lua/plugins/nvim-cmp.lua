-- autocomplete configuraiton
-- https://github.com/hrsh7th/nvim-cmp

return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "FelipeLema/cmp-async-path",
    "dcampos/nvim-snippy",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "onsails/lspkind.nvim",
    "windwp/nvim-autopairs",
  },
  event = "InsertEnter",

  init = function()
    vim.o.completeopt = "menu,menuone,preview"
  end,

  config = function()
    local cmp = require("cmp")
    local ctx = require("cmp.config.context")

    cmp.setup({
      enabled = function()
        if vim.b.copilot_active then
          return false
        end

        -- https://github.com/hrsh7th/nvim-cmp/wiki/Advanced-techniques
        if vim.api.nvim_get_mode().mode == "c" then
          return true
        end

        return not ctx.in_treesitter_capture("comment")
          and not ctx.in_syntax_group("Comment")
      end,

      view = {
        entries = "native",
      },

      formatting = {
        format = require("lspkind").cmp_format({
          mode = "symbol_text",
          maxwidth = 50,
          ellipsis_char = "...",
        }),
      },

      mapping = {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            -- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#intellij-like-mapping
            if not cmp.get_selected_entry() then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            end
            cmp.confirm()
          else
            fallback()
          end
        end, { "i", "s", "c" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { "i", "s", "c" }),
        ["<Down>"] = cmp.mapping.select_next_item(),
        ["<Up>"] = cmp.mapping.select_prev_item(),
        ["<C-c>"] = cmp.mapping.abort(),
        -- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#safely-select-entries-with-cr
        ["<CR>"] = cmp.mapping({
          i = function(fallback)
            if cmp.visible() and cmp.get_active_entry() then
              return cmp.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select = false,
              })
            end
            return fallback()
          end,
          s = cmp.mapping.confirm({ select = true }),
          c = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
        }),
      },

      sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        {
          name = "async_path",
          option = {
            trailing_slash = true,
          },
        },
        { name = "buffer" },
      },
    })

    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    cmp.event:on("menu_opened", function()
      vim.b.copilot_suggestion_hidden = true
    end)
    cmp.event:on("menu_closed", function()
      vim.b.copilot_suggestion_hidden = false
    end)
  end,
}
