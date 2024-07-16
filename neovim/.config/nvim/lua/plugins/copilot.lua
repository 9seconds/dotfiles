-- Copilot stuff

-- https://github.com/zbirenbaum/copilot.lua
local copilot_config = {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",

  config = function()
    local copilot = require("copilot")

    copilot.setup({
      panel = {
        enabled = false,
      },
      suggestion = {
        auto_trigger = true,
        keymap = {
          -- gonna use tab, so setup it in cmp
          accept = false,
          accept_word = "<M-w>",
          accept_line = "<M-l>",
          next = "<M-]>",
          prev = "<M-[>",
          -- gonna use s-tab so setup in cmp
          dismiss = false,
        },
      },
    })

    local group = vim.api.nvim_create_augroup("9_Copilot", {})

    vim.api.nvim_create_autocmd({ "User" }, {
      group = group,
      pattern = "_9CopilotShow",
      callback = function()
        vim.b.copilot_suggestion_auto_trigger = true
        vim.b.copilot_suggestion_hidden = false
      end,
    })

    vim.api.nvim_create_autocmd({ "User" }, {
      group = group,
      pattern = "_9CopilotHide",
      callback = function()
        vim.b.copilot_suggestion_auto_trigger = false
        vim.b.copilot_suggestion_hidden = true
      end,
    })

    local function trigger()
      local commands = require("copilot.command")
      if vim.g.use_copilot then
        commands.enable()
        commands.attach()
      else
        commands.detach()
        commands.disable()
      end
    end

    vim.api.nvim_create_autocmd({ "User" }, {
      group = group,
      pattern = "_9CopilotUse",
      callback = trigger,
    })

    trigger()
  end,
}

return {
  copilot_config,
}
--
-- return {
--   "zbirenbaum/copilot.lua",
--   cmd = "Copilot",
--   event = "InsertEnter",
--   config = function()
--     if vim.g.use_copilot then
--       require("copilot").setup({
--         suggestion = {
--           auto_trigger = true,
--         },
--       })
--
--       vim.keymap.set("i", "<C-l>", function()
--         local autopairs = require("nvim-autopairs")
--         local suggestion = require("copilot.suggestion")
--
--         autopairs.disable()
--         suggestion.accept()
--         autopairs.enable()
--       end, { desc = "Accept Copilot suggestion" })
--     end
--   end,
-- }
