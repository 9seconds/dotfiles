-- autocompletion
-- https://github.com/Saghen/blink.cmp

return {
  "Saghen/blink.cmp",
  dependencies = {
    {
      "xzbdmw/colorful-menu.nvim",
      config = true,
    },
  },
  version = "*",
  event = "FileType",

  opts = {
    keymap = {
      preset = "none",

      ["<c-a>"] = {
        "select_and_accept",
        "fallback",
      },
      ["<c-c>"] = {
        function(cmp)
          if cmp.is_active() then
            cmp.cancel()
          end
          if package.loaded["copilot"] then
            require("copilot.suggestion").next()
            return true
          end
        end,
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

    local augroup = vim.api.nvim_create_augroup("9_Blink", {})
    vim.api.nvim_create_autocmd("User", {
      pattern = "BlinkCmpMenuOpen",
      group = augroup,
      callback = function()
        vim.b.copilot_suggestion_hidden = true
      end,
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "BlinkCmpMenuClose",
      group = augroup,
      callback = function()
        vim.b.copilot_suggestion_hidden = false
      end,
    })
  end,
}
