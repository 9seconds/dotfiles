-- autocompletion
-- https://github.com/Saghen/blink.cmp

vim.pack.add({
  "https://github.com/xzbdmw/colorful-menu.nvim",
  {
    src = "https://github.com/fang2hou/blink-copilot",
    version = vim.version.range("*"),
  },
  {
    src = "https://github.com/Saghen/blink.cmp",
    version = vim.version.range("1.*"),
  },
})

require("blink.cmp").setup({
  keymap = {
    -- see 20-mini-keymap
    preset = "none",
    ["<c-s>"] = {
      function(cmp)
        if cmp.is_signature_visible() then
          cmp.hide_signature()
        else
          cmp.show_signature()
        end
        return true
      end,
      "fallback",
    },
  },
  -- https://cmp.saghen.dev/configuration/completion.html
  completion = {
    keyword = {
      range = "full",
    },
    trigger = {
      show_on_trigger_character = true,
    },
    list = {
      selection = {
        preselect = true,
        auto_insert = true,
      },
    },
    documentation = {
      auto_show = false,
    },
    accept = {
      auto_brackets = {
        enabled = false,
      },
    },
    ghost_text = {
      enabled = function()
        return vim.g.copilot_mode or false
      end,
    },
    menu = {
      auto_show = function()
        return not vim.g.copilot_mode
      end,
      draw = {
        -- see https://github.com/xzbdmw/colorful-menu.nvim
        columns = { { "kind_icon" }, { "label", gap = 1 } },
        components = {
          label = {
            text = function(ctx)
              return require("colorful-menu").blink_components_text(ctx)
            end,
            highlight = function(ctx)
              return require("colorful-menu").blink_components_highlight(ctx)
            end,
          },
        },
        treesitter = { "lsp" },
      },
    },
  },
  snippets = {
    preset = "mini_snippets",
  },
  fuzzy = {
    implementation = "rust",
  },
  signature = {
    enabled = true,
    trigger = {
      show_on_trigger_character = false,
      show_on_insert_on_trigger_character = false,
      show_on_accept_on_trigger_character = false,
    },
    window = {
      show_documentation = true,
    },
  },
  sources = {
    default = function()
      if vim.g.copilot_mode then
        return { "copilot" }
      end
      return { "lsp", "snippets", "path" }
    end,
    providers = {
      copilot = {
        name = "copilot",
        module = "blink-copilot",
        score_offset = 100,
        async = true,
      },
    },
  },
})
