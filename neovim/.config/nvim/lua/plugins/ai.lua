-- AI stuff

-- copilot
-- https://github.com/zbirenbaum/copilot.lua
local copilot_config = {
  "zbirenbaum/copilot.lua",
  dependencies = {
    "Saghen/blink.cmp",
  },
  cmd = "Copilot",
  keys = {
    {
      "<C-c>",
      function()
        require("copilot.suggestion").toggle_auto_trigger()
        require("blink.cmp").hide()
      end,
      mode = { "n", "i", "v" },
      desc = "Toggle Copilot",
    },
  },

  opts = {
    panel = {
      enabled = false,
    },
    suggestion = {
      enabled = true,
      auto_trigger = false,
      keymap = {
        accept = "<C-a>",
        accept_word = "<M-w>",
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-q>",
      },
    },
  },
}

local copilot_chat = {
  "CopilotC-Nvim/CopilotChat.nvim",
  version = "*",
  dependencies = {
    "zbirenbaum/copilot.lua",
    "nvim-lua/plenary.nvim",
    {
      "gptlang/lua-tiktoken",
      version = "*",
    },
    "nvim-telescope/telescope.nvim",
  },
  cmd = {
    "CopilotChat",
    "CopilotChatOpen",
    "CopilotChatClose",
    "CopilotChatToggle",
    "CopilotChatStop",
    "CopilotChatReset",
    "CopilotChatSave",
    "CopilotChatLoad",
    "CopilotChatDebugInfo",
    "CopilotChatModels",
  },
  keys = {
    {
      "<leader>aa",
      function()
        vim.ui.input({ prompt = "Ask Copilot: " }, function(text)
          text = text or ""
          if text ~= "" then
            require("CopilotChat").ask(text)
          end
        end)
      end,
      mode = { "n", "v", "x" },
      desc = "Open Copilot chat",
    },
    {
      "<leader>ar",
      function()
        require("CopilotChat").reset()
      end,
      desc = "Reset Copilot chat",
    },
    {
      "<leader>at",
      function()
        require("CopilotChat").toggle()
      end,
      desc = "Toggle Copilot chat",
    },
    {
      "<leader>ta",
      function()
        local actions = require("CopilotChat.actions")

        local all_actions = {}

        for k, v in pairs(actions.help_actions() or {}) do
          all_actions[k] = v
        end

        for k, v in pairs(actions.prompt_actions() or {}) do
          all_actions[k] = v
        end

        require("CopilotChat.integrations.telescope").pick(all_actions)
      end,
      mode = { "n", "v", "x" },
      desc = "Show telescope",
    },
  },

  opts = {},
}

return {
  copilot_config,
  copilot_chat,
}
