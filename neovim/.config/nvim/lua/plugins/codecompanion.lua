-- ai
-- https://codecompanion.olimorris.dev/
-- https://github.com/olimorris/codecompanion.nvim

return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  version = "*",
  cmd = {
    "CodeCompanion",
    "CodeCompanionChat",
    "CodeCompanionCmd",
    "CodeCompanionActions",
  },
  keys = {
    {
      "<A-c>",
      "<cmd>CodeCompanionChat Toggle<cr>",
      mode = { "i", "n", "v" },
      desc = "Open Code Companion",
    },
    {
      "ga",
      "<cmd>CodeCompanionChat Add<cr>",
      mode = "v",
      desc = "Add to Code Companion",
    },
  },

  opts = function()
    return vim.tbl_deep_extend("keep", vim.g.codecompanion_config or {}, {
      opts = {
        send_code = true,
      },

      strategies = {
        chat = {
          opts = {
            prompt_decorator = function(message)
              return string.format("<prompt>%s</prompt>", message)
            end,
            goto_file_action = "vsplit",
          },

          roles = {
            llm = function(adapter)
              return string.format("AI (%s)", adapter.formatted_name)
            end,
          },

          tools = {
            opts = {
              default_tools = {
                "files",
                "insert_edit_into_file",
              },
            },
          },
        },
      },

      display = {
        chat = {
          child_window = {
            width = math.floor(vim.o.columns * 0.7),
            height = math.floor(vim.o.lines * 0.7),
          },
          fold_context = true,
          fold_reasoning = true,
          show_token_count = false,
          start_in_insert_mode = true,
          intro_message = "",
        },
      },

      memory = {
        mem_global = {
          description = "Global memory",
          parser = "claude",
          files = {
            "~/.local/share/nvim/cc/rules.md",
          },
        },
        mem_project = {
          description = "Project-specific memory",
          parser = "claude",
          files = {
            ".cc/*.md",
            ".claude/*.md",
            "CLAUDE.md",
            "CLAUDE.local.md",
          },
        },

        opts = {
          chat = {
            enabled = true,
            default_params = "watch",
            default_memory = { "mem_global", "mem_project" },
          },
        },
      },
    })
  end,
}
