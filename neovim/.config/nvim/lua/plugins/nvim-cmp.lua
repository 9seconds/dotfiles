-- autocomplete configuraiton
-- https://github.com/hrsh7th/nvim-cmp

return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "windwp/nvim-autopairs",
    "FelipeLema/cmp-async-path",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "onsails/lspkind.nvim",
    "dcampos/nvim-snippy",
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
            cmp.select_next_item()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<Down>"] = cmp.mapping.select_next_item(),
        ["<Up>"] = cmp.mapping.select_prev_item(),
        ["<C-c>"] = cmp.mapping.abort(),
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
  end,
}
