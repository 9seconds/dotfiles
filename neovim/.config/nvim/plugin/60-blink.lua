-- autocompletion
-- https://github.com/Saghen/blink.cmp

require("_.pack").add({
  url = "https://github.com/Saghen/blink.cmp",
  releases = vim.version.range("1.*"),
  lazy = "InsertEnter",

  config = function()
    require("blink.cmp").setup({
      keymap = {
        -- see 20-mini-keymap
        preset = "none",
        ["<c-s"] = {
          "show_signature",
          "hide_signature",
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
                  return require("colorful-menu").blink_components_highlight(
                    ctx
                  )
                end,
              },
            },
            treesitter = { "lsp" },
          },
        },
      },

      fuzzy = {
        implementation = "rust",
      },

      signature = {
        enabled = false,
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
          codecompanion = {
            name = "CodeCompanion",
            module = "codecompanion.providers.completion.blink",
          },
        },
        per_filetype = {
          codecompanion = { "codecompanion" },
        },
      },
    })
  end,
})
