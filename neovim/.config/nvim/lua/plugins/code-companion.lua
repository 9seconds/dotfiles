-- AI companion
-- https://github.com/olimorris/codecompanion.nvim

-- local function get_openrouter_config(model)
--   return require("codecompanion.adapters").extend("openai_compatible", {
--     env = {
--       url = "https://openrouter.ai/api",
--       api_key = "OPENROUTER_API_KEY",
--       chat_url = "/v1/chat/completions",
--     },
--     schema = {
--       model = {
--         default = model,
--       },
--     },
--   })
-- end

local function get_config(config)
  if config == nil then
    return get_config("copilot")
  end

  if type(config) == "string" then
    return get_config({ chat = config, inline = config })
  end

  if config.chat == nil then
    return get_config(vim.tbl_extend("force", config, { chat = config }))
  end

  if config.inline == nil then
    return get_config(vim.tbl_extend("force", config, { inline = config.chat }))
  end

  if type(config.chat) == "table" then
    -- {chat = {"copilot", {schema = {model = {"gpt-4o"}}}}}
    return get_config(vim.tbl_extend("force", config, {
      chat = function()
        return require("codecompanion.adapters").extend(
          config.chat[1],
          config.chat[2]
        )
      end,
    }))
  end

  if type(config.inline) == "table" then
    -- {inline = {"copilot", {schema = {model = {"gpt-4o"}}}}}
    return get_config(vim.tbl_extend("force", config, {
      inline = function()
        return require("codecompanion.adapters").extend(
          config.inline[1],
          config.inline[2]
        )
      end,
    }))
  end

  return config
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
      "<leader>at",
      "<cmd>CodeCompanionChat Toggle<cr>",
      mode = { "n", "v", "o" },
    },
    {
      "<leader>ac",
      "<cmd>CodeCompanionActions<cr>",
    },
    {
      "<leader>aa",
      "<cmd>CodeCompanionChat Add<cr>",
      mode = { "v" },
    },
  },
  cmd = {
    "CodeCompanion",
    "CodeCompanionChat",
    "CodeCompanionActions",
    "CodeCompanionCmd",
  },

  opts = function()
    return {
      adapters = get_config(vim.g.code_companion_config),

      display = {
        chat = {
          intro_message = "",
          start_in_insert_mode = true,
        },
        action_palette = {
          provider = "telescope",
        },
      },

      strategies = {
        chat = {
          adapter = "chat",

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
          adapter = "inline",
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
