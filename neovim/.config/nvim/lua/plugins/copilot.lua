-- Copilot stuff
-- https://github.com/zbirenbaum/copilot.lua

local copilot_config = {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  keys = {
    {
      "<leader>cc",
      function()
        require("_.copilot"):user_toggle()
      end,
      mode = { "n", "o" },
      desc = "Toggle Copilot",
    },
    {
      "<C-c>",
      function()
        require("_.copilot"):user_toggle()
      end,
      mode = "i",
      desc = "Toggle Copilot",
    },
  },

  config = function()
    require("copilot").setup({
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
    })
    require("_.copilot"):activate()
  end,
}

local copilot_chat_config = {
  "CopilotC-Nvim/CopilotChat.nvim",
  version = "*",
  dependencies = {
    "zbirenbaum/copilot.lua",
    "nvim-lua/plenary.nvim",
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
    "CopilotChatExplain",
    "CopilotChatReview",
    "CopilotChatFix",
    "CopilotChatOptimize",
    "CopilotChatDocs",
    "CopilotChatTests",
    "CopilotChatFixDiagnostic",
    "CopilotChatCommit",
    "CopilotChatCommitStaged",
  },
  keys = {
    {
      "<leader>ca",
      function()
        vim.ui.input({ prompt = "Ask Copilot: " }, function(text)
          text = text or ""
          if text ~= "" then
            require("CopilotChat").ask(
              text,
              { selection = require("CopilotChat.select").buffer }
            )
          end
        end)
      end,
      mode = { "n", "v" },
      desc = "Open Copilot chat",
    },
    {
      "<leader>cr",
      function()
        require("CopilotChat").reset()
      end,
      desc = "Reset Copilot chat",
    },
  },

  opts = {},
}

return {
  copilot_config,
  copilot_chat_config,
}
