-- autocomplete configuraiton
-- https://github.com/hrsh7th/nvim-cmp

local function has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))

  if col == 0 then
    return false
  end

  local lne = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
  return not lne:sub(col, col):match("%s")
end

local function tab_action(action, fallback)
  local cmp = require("cmp")

  if cmp.visible() then
    return action()
  elseif has_words_before() then
    return cmp.complete()
  end

  return fallback()
end

return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "windwp/nvim-autopairs",
    "abecodes/tabout.nvim",
    "FelipeLema/cmp-async-path",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "onsails/lspkind.nvim",
    "dcampos/nvim-snippy",
    "dcampos/cmp-snippy",
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

      snippet = {
        expand = function(args)
          return require("snippy").expand_snippet(args.body)
        end,
      },

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
          return tab_action(cmp.select_next_item, fallback)
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          return tab_action(cmp.select_prev_item, fallback)
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
        { name = "snippy" },
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
