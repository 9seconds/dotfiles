-- AI stuff

-- copilot
-- https://github.com/zbirenbaum/copilot.lua
local copilot_config = {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  keys = {
    {
      "<C-c>",
      function()
        local copilot = require("copilot.suggestion")
        local blink = package.loaded["blink.cmp"]

        copilot.toggle_auto_trigger()
        copilot.dismiss()

        if blink then
          blink.hide()
        end
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
    "nvim-telescope/telescope.nvim",
  },
  build = "make tiktoken",
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
      "<cmd>CopilotChat<cr>",
      mode = { "n", "v", "x" },
      desc = "Open Copilot chat",
    },
    {
      "<leader>ar",
      "<cmd>CopilotChatReset",
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
