-- copilot chat
-- https://github.com/CopilotC-Nvim/CopilotChat.nvim

return {
  "CopilotC-Nvim/CopilotChat.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "zbirenbaum/copilot.lua",
  },
  build = "make tiktoken",
  cmd = {
    "CopilotChat",
    "CopilotChatOpen",
    "CopilotChatToggle",
    "CopilotChatClose",
    "CopilotChatStop",
    "CopilotChatReset",
    "CopilotChatSave",
    "CopilotChatLoad",
    "CopilotChatPrompts",
    "CopilotChatModels",
  },
  keys = {
    {
      "<leader>ct",
      function()
        return require("CopilotChat").toggle()
      end,
      mode = { "n", "x", "o" },
      desc = "Copilot Chat: Toggle window",
    },
    {
      "<leader>cp",
      function()
        return require("CopilotChat").select_prompt()
      end,
      desc = "Copilot Chat: Select prompt",
    },
  },

  config = function()
    local mod = require("CopilotChat")

    mod.setup({
      model = vim.g.copilot_chat_model,
      auto_insert_mode = true,
      clear_chat_on_new_prompt = true,
      selection = function(source)
        local sel = require("CopilotChat.select")
        return sel.visual(source) or sel.line(source)
      end,
    })

    vim.api.nvim_create_autocmd("BufEnter", {
      group = vim.api.nvim_create_augroup("9_CopilotChat", {}),
      pattern = "copilot-*",
      callback = function()
        vim.wo.relativenumber = false
        vim.wo.number = false
        vim.wo.conceallevel = 0
      end,
    })
  end,
}
