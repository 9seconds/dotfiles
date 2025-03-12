-- autocompletion
-- https://github.com/Saghen/blink.cmp

return {
  "Saghen/blink.cmp",
  version = "*",
  event = "InsertEnter",

  opts = {
    enabled = function()
      return not vim.b.copilot_suggestion_auto_trigger
    end,

    keymap = {
      preset = "none",

      ["<C-a>"] = {
        "select_and_accept",
      },
      ["<C-n>"] = {
        "select_next",
        "fallback",
      },
      ["<C-p>"] = {
        "select_prev",
        "fallback",
      },
      ["<C-d>"] = {
        "show_documentation",
        "hide_documentation",
        "fallback",
      },
    },

    completion = {
      keyword = {
        range = "prefix",
      },
      trigger = {
        show_on_keyword = true,
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 1000,
      },
      list = {
        selection = {
          preselect = true,
        },
      },
      accept = {
        auto_brackets = {
          enabled = false,
        },
      },
      menu = {
        auto_show = function(ctx)
          if ctx.mode == "cmdline" or vim.bo.buftype == "prompt" then
            return false
          end
          return not vim.tbl_contains({ "/", "?" }, vim.fn.getcmdtype())
        end,
      },
    },

    signature = {
      enabled = true,
    },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },

    sources = {
      default = { "lsp", "path", "buffer" },
      per_filetype = {
        codecompanion = { "codecompanion" },
      },
    },
  },
}
