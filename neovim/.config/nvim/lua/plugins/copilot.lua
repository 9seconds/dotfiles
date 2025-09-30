-- copilot
-- https://github.com/zbirenbaum/copilot.lua

return {
  "zbirenbaum/copilot.lua",
  dependencies = {
    {
      "copilotlsp-nvim/copilot-lsp",
      init = function()
        vim.g.copilot_nes_debounce = 500
        vim.lsp.enable("copilot_ls")
      end,
    },
  },
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
        next = "<c-c>",
        accept_word = "<c-w>",
        accept_line = "<c-l>",
        dismiss = "<c-d>",
      },
    },
    nes = {
      enabled = false,
      keymap = {
        accept_and_goto = "<c-i>",
        dismiss = "<esc>",
      },
    },
  },

  config = function(_, opts)
    require("copilot").setup(opts)
    require("copilot.status").register_status_notification_handler(
      function(data)
        if vim.b.copilot_suggestion_auto_trigger then
          vim.g.copilot_status = "InProgress"
        else
          vim.g.copilot_status = data.status
        end

        local lualine = package.loaded["lualine"]
        if lualine then
          lualine.refresh()
        end
      end
    )

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
