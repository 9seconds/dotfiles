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
      function()
        require("CopilotChat").open()
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

  opts = {
    model = "claude-3.7-sonnet",
  },

  config = function(_, opts)
    require("CopilotChat").setup(opts)

    vim.api.nvim_create_autocmd("BufEnter", {
      group = vim.api.nvim_create_augroup("9_Copilot", {}),
      pattern = "copilot-chat",
      callback = function()
        vim.cmd("normal G")
        vim.cmd("startinsert!")

        vim.keymap.set("i", "<c-h>", "<c-o><c-w>h<esc>", { buffer = true })
        vim.keymap.set("i", "<c-l>", "<c-o><c-w>l<esc>", { buffer = true })
        vim.keymap.set("i", "<c-q>", "<c-o><c-w>c<esc>", { buffer = true })
        vim.keymap.set(
          "i",
          "<c-r>",
          "<c-o>:CopilotChatReset<esc>i",
          { buffer = true }
        )
        vim.keymap.set("n", "<c-r>", function()
          require("CopilotChat").reset()
        end, { buffer = true })
      end,
    })
  end,
}

return {
  copilot_config,
  copilot_chat,
}
