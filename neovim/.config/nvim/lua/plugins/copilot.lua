-- copilot
-- https://github.com/zbirenbaum/copilot.lua

return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",

  opts = {
    panel = {
      enabled = false,
    },
    suggestion = {
      enabled = true,
      auto_trigger = true,
      keymap = {
        accept = "<c-a>",
        next = "<c-n>",
        prev = "<c-p>",
        accept_word = "<c-w>",
        accept_line = "<c-l>",
        dismiss = "<c-d>",
      },
    },
  },

  config = function(_, opts)
    require("copilot").setup(opts)

    local function toggle_copilot()
      local enable = not vim.g.enable_autocompletion
      vim.b.copilot_suggestion_auto_trigger = enable
      vim.b.copilot_suggestion_hidden = not enable

      local mod = require("copilot.suggestion")
      if enable then
        mod.next()
      else
        mod.dismiss()
      end
    end

    toggle_copilot()

    local group = vim.api.nvim_create_augroup("9_Copilot", {})
    vim.api.nvim_create_autocmd("User", {
      group = group,
      pattern = "EnableAutocompleteToggled",
      callback = toggle_copilot,
    })

    vim.api.nvim_create_autocmd({ "BufRead", "BufEnter" }, {
      group = group,
      callback = toggle_copilot,
    })
  end,
}
