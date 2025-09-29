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

    vim.api.nvim_create_autocmd("BufEnter", {
      group = vim.api.nvim_create_augroup("9_Copilot", {}),
      callback = function()
        vim.b.copilot_suggestion_auto_trigger = vim.g.enable_autocompletion
      end,
    })
  end,
}
