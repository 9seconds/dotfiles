-- AI companion
-- https://github.com/olimorris/codecompanion.nvim

local DEFAULT_ADAPTER = "copilot"
local DEFAULT_OPENROUTER_ADAPTER = "anthropic/claude-3.7-sonnet"

local function get_openrouter_config(model)
  return require("codecompanion.adapters").extend("openai_compatible", {
    env = {
      url = "https://openrouter.ai/api",
      api_key = "OPENROUTER_API_KEY",
      chat_url = "/v1/chat/completions",
    },
    schema = {
      model = {
        default = model,
      },
    },
  })
end

return {
  "olimorris/codecompanion.nvim",
  version = "*",
  dependencies = {
    "zbirenbaum/copilot.lua",
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  keys = {
    {
      "<leader>aa",
      "<cmd>CodeCompanionChat Toggle<cr>",
      mode = { "n", "v", "o" },
    },
    {
      "<leader>ac",
      "<cmd>CodeCompanionActions<cr>",
    },
  },
  cmd = {
    "CodeCompanion",
    "CodeCompanionChat",
    "CodeCompanionActions",
    "CodeCompanionCmd",
  },

  opts = function()
    local global_adapter = os.getenv("CODE_COMPANION_ADAPTER")
      or DEFAULT_ADAPTER
    local chat_adapter = os.getenv("CODE_COMPANION_ADAPTER_CHAT")
      or global_adapter
    local inline_adapter = os.getenv("CODE_COMPANION_ADAPTER_INLINE")
      or global_adapter

    local openrouter_adapter = os.getenv("CODE_COMPANION_OPENROUTER_ADAPTER")
      or DEFAULT_OPENROUTER_ADAPTER
    local or_chat_adapter = os.getenv("CODE_COMPANION_OPENROUTER_CHAT_ADAPTER")
      or openrouter_adapter
    local or_inline_adapter = os.getenv(
      "CODE_COMPANION_OPENROUTER_INLINE_ADAPTER"
    ) or openrouter_adapter

    return {
      display = {
        action_palette = {
          provider = "telescope",
        },
      },

      adapters = {
        openrouter_chat = get_openrouter_config(or_chat_adapter),
        openrouter_inline = get_openrouter_config(or_inline_adapter),
      },

      strategies = {
        chat = {
          adapter = chat_adapter,

          slash_commands = {
            ["file"] = {
              opts = {
                provider = "telescope",
              },
            },
            ["buffer"] = {
              opts = {
                provider = "telescope",
              },
            },
            ["symbols"] = {
              opts = {
                provider = "telescope",
              },
            },
          },

          keymaps = {
            completion = {
              modes = {
                i = "<C-a>",
              },
            },
          },
        },
        inline = {
          adapter = inline_adapter,
        },
      },
    }
  end,

  config = function(_, opts)
    require("codecompanion").setup(opts)

    local group = vim.api.nvim_create_augroup("9_CodeCompanion", {})

    vim.api.nvim_create_autocmd("User", {
      pattern = "CodeCompanionRequestStarted",
      group = group,
      callback = function()
        local utils = require("_.utils")

        vim.g.code_companion_in_progress = true
        utils.refresh_statusline()
      end,
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "CodeCompanionRequestFinished",
      group = group,
      callback = function()
        local utils = require("_.utils")

        vim.g.code_companion_in_progress = false
        utils.refresh_statusline()
      end,
    })
  end,
}
