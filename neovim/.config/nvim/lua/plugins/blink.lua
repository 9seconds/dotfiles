-- autocompletion
-- https://github.com/Saghen/blink.cmp

return {
  "Saghen/blink.cmp",
  dependencies = {
    "fang2hou/blink-copilot",
    {
      "xzbdmw/colorful-menu.nvim",
      config = true,
    },
  },
  version = "*",
  event = "FileType",

  opts = {
    enabled = function()
      return vim.bo.filetype ~= "copilot-chat"
    end,

    keymap = {
      preset = "none",

      ["<c-a>"] = {
        "select_and_accept",
      },
      ["<c-n>"] = {
        "select_next",
        "fallback",
      },
      ["<c-p>"] = {
        "select_prev",
        "fallback",
      },
      ["<c-d>"] = {
        "show_documentation",
        "hide_documentation",
        "fallback",
      },
      ["<c-k>"] = {
        "show_signature",
        "hide_signature",
        "fallback",
      },
    },

    completion = {
      keyword = {
        range = "full",
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
          auto_insert = true,
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

    fuzzy = {
      implementation = "rust",
    },

    signature = {
      enabled = true,
    },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },

    sources = {
      default = { "lsp", "path", "buffer", "copilot" },
      providers = {
        copilot = {
          name = "copilot",
          module = "blink-copilot",
          score_offset = 100,
          async = true,
        },
      },
    },
  },
}
