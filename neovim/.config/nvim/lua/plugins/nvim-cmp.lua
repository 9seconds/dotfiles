-- autocomplete configuraiton
-- https://github.com/hrsh7th/nvim-cmp

local function has_words_before()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
    return false
  end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0
    and vim.api
        .nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]
        :match("^%s*$")
      == nil
end

return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "FelipeLema/cmp-async-path",
    "dcampos/nvim-snippy",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "onsails/lspkind.nvim",
    "windwp/nvim-autopairs",
    "zbirenbaum/copilot-cmp",
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
          if cmp.visible() and has_words_before() then
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

      sorting = {
        priority_weight = 2,
        comparators = {
          require("copilot_cmp.comparators").prioritize,

          -- Below is the default comparitor list and order for nvim-cmp
          -- https://github.com/hrsh7th/nvim-cmp/blob/d818fd0624205b34e14888358037fb6f5dc51234/lua/cmp/config/default.lua#L65-L79
          cmp.config.compare.offset,
          -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
          cmp.config.compare.exact,
          cmp.config.compare.score,
          cmp.config.compare.recently_used,
          cmp.config.compare.locality,
          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      },

      sources = {
        { name = "copilot" },
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
