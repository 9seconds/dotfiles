-- autocompletion
-- https://github.com/Saghen/blink.cmp

return {
  "Saghen/blink.cmp",
  dependencies = {
    {
      "xzbdmw/colorful-menu.nvim",
      config = true,
    },
    "zbirenbaum/copilot.lua",
  },
  version = "*",
  event = "InsertEnter",

  opts = {
    enabled = function()
      return vim.g.enable_autocompletion
    end,

    keymap = {
      preset = "none",

      ["<c-a>"] = {
        "select_and_accept",
        "fallback",
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
      default = { "lsp", "path", "buffer" },
      per_filetype = {
        codecompanion = { "codecompanion" },
      },
    },
  },

  config = function(_, opts)
    require("blink-cmp").setup(opts)

    vim.api.nvim_create_autocmd("User", {
      pattern = "EnableAutocompleteToggled",
      group = vim.api.nvim_create_augroup("9_Blink", {}),
      callback = function()
        if not vim.g.enable_autocompletion then
          require("blink.cmp").cancel()
        end
      end,
    })
  end,
}
