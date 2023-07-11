-- autocomplete configuraiton
-- https://github.com/hrsh7th/nvim-cmp

return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "windwp/nvim-autopairs",
    "abecodes/tabout.nvim",
    "FelipeLema/cmp-async-path",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp",
    "onsails/lspkind.nvim",
    "ray-x/lsp_signature.nvim"
  },
  event = "InsertEnter",

  config = function()
    local cmp = require("cmp")

    cmp.setup({
      view = {
        entries = "native"
      },

      formatting = {
        format = require("lspkind").cmp_format({
          mode = "symbol_text",
          maxwidth = 50,
          ellipsis_char = "...",
        }),
      },

      mapping = {
        ["<Tab>"] = function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end,
        ["<S-Tab>"] = function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end,
        ["<Down>"] = cmp.mapping.select_next_item(),
        ["<Up>"] = cmp.mapping.select_prev_item(),
        ["<C-c>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping({
          i = function(fallback)
            if cmp.visible() and cmp.get_active_entry() then
              cmp.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select = false,
              })
            else
              fallback()
            end
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
        {
          name = "async_path",
          option = {
            trailing_slash = true
          }
        },
        {
          name = "buffer",
          option = {
            get_bufnrs = function()
              local bufs = {}
              for _, win in ipairs(vim.api.nvim_list_wins()) do
                bufs[vim.api.nvim_win_get_buf(win)] = true
              end
              return vim.tbl_keys(bufs)
            end
          }
        },
      }
    })

    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end
}
