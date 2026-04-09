-- ai
-- https://codecompanion.olimorris.dev/
-- https://github.com/olimorris/codecompanion.nvim

require("_.pack").add({
  url = "https://github.com/olimorris/codecompanion.nvim",
  releases = true,

  config = function()
    require("codecompanion").setup({
      interactions = {
        chat = {
          opts = {
            -- https://codecompanion.olimorris.dev/configuration/chat-buffer#prompt-decorator
            prompt_decorator = function(message)
              return string.format("<prompt>%s</prompt>", message)
            end,
            goto_file_action = "vsplit",
          },
          tools = {
            opts = {
              -- https://codecompanion.olimorris.dev/configuration/chat-buffer#default-tools
              default_tools = {
                -- https://codecompanion.olimorris.dev/usage/chat-buffer/agents-tools#agent
                "agent",
              },
            },
          },
          -- https://codecompanion.olimorris.dev/configuration/chat-buffer#roles
          roles = {
            user = "Me",
            llm = function(adapter)
              return "CodeCompanion (" .. adapter.formatted_name .. ")"
            end,
          },
          -- https://codecompanion.olimorris.dev/configuration/chat-buffer#syncing
          editor_context = {
            buffer = {
              opts = {
                default_params = "diff",
              },
            },
          },
        },
      },

      display = {
        chat = {
          -- https://codecompanion.olimorris.dev/configuration/chat-buffer#reasoning
          fold_reasoning = true,
          -- https://codecompanion.olimorris.dev/configuration/chat-buffer#others
          show_token_count = false,
          intro_message = "",
        },
      },

      -- https://codecompanion.olimorris.dev/configuration/others
      opts = {
        language = "English",
        send_code = true,
        per_project_config = {
          files = {
            ".codecompanion.lua",
          },
        },
      },
    })

    vim.keymap.set(
      { "i", "n", "v", "t", "x", "s" },
      "<A-c>",
      "<cmd>CodeCompanionChat Toggle<cr>",
      {
        desc = "Code Companion: Open Chat",
      }
    )
    vim.keymap.set({ "s", "v" }, "<A-s>", "<cmd>CodeCompanionChat Add<cr>", {
      desc = "Code Companion: Add selection to Chat",
    })
    vim.keymap.set("n", "<A-s>", "V<cmd>CodeCompanionChat Add<cr><Esc>", {
      desc = "Code Companion: Add current line to Chat",
    })
  end,
})
