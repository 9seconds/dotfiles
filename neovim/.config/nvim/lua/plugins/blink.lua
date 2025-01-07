-- autocompletion
-- https://github.com/Saghen/blink.cmp

local function enable_blink(cmp)
  local copilot = package.loaded["copilot.suggestion"]

  vim.b.copilot_suggestion_auto_trigger = false

  if copilot then
    copilot.dismiss()
  end

  cmp.show()
end

return {
  "Saghen/blink.cmp",
  version = "*",
  event = "InsertEnter",

  opts = {
    keymap = {
      preset = "none",

      ["<Tab>"] = {
        "fallback",
      },
      ["<C-CR>"] = {
        "select_and_accept",
        "fallback",
      },
      ["<C-n>"] = {
        enable_blink,
        "select_next",
        "fallback",
      },
      ["<C-p>"] = {
        enable_blink,
        "select_prev",
        "fallback",
      },
      ["<C-d>"] = {
        enable_blink,
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
        selection = function(ctx)
          return ctx.mode == "cmdline" and "auto_insert" or "preselect"
        end,
      },
      accept = {
        auto_brackets = {
          enabled = false,
        },
      },
    },

    signature = {
      enabled = true,
    },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },

    -- sources = {
    --   default = { "lsp", "path", "buffer" },
    -- },
  },
}
