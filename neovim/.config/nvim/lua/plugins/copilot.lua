-- Copilot stuff
-- https://github.com/zbirenbaum/copilot.lua

local copilot_config = {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  keys = {
    {
      "<C-c>",
      function()
        require("_.copilot").user_toggle()
      end,
      mode = { "n", "i", "v" },
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

    if not vim.g.use_copilot then
      require("copilot.command").disable()
    end
  end,
}

local copilot_chat_config = {
  "CopilotC-Nvim/CopilotChat.nvim",
  version = "*",
  dependencies = {
    "zbirenbaum/copilot.lua",
    "nvim-lua/plenary.nvim",
    {
      "gptlang/lua-tiktoken",
      version = "*",
    },
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
  },

  opts = {},
}

return {
  copilot_config,
  copilot_chat_config,
}
