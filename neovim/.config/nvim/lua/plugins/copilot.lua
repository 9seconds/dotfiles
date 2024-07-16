-- Copilot
-- https://github.com/zbirenbaum/copilot.lua


return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    if vim.g.use_copilot then
      require("copilot").setup({
        suggestion = {
          auto_trigger = true,
        }
      })

    vim.keymap.set("i", "<C-l>", function()
      local autopairs = require("nvim-autopairs")
      local suggestion = require("copilot.suggestion")

      autopairs.disable()
      suggestion.accept()
      autopairs.enable()
    end, { desc = "Accept Copilot suggestion" })
    end
  end
}
