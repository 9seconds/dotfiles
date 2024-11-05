-- autocompletion
-- https://github.com/Saghen/blink.cmp

local function enable_blink(cmp)
  vim.b.copilot_suggestion_auto_trigger = false
  cmp.show()
end

return {
  "Saghen/blink.cmp",
  version = "*",
  event = "InsertEnter",

  opts = {
    keymap = {
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
    nerd_font_variant = "mono",
    highlight = {
      use_nvim_cmp_as_default = true,
    },
    sources = {
      completion = {
        enabled_providers = function()
          if vim.b.copilot_suggestion_auto_trigger then
            return {}
          end
          return { "lsp", "path", "buffer" }
        end,
      },
      providers = {
        path = {
          get_cwd = vim.uv.cwd,
        },
      },
    },
  },
}
