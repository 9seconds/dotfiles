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
        require("copilot.suggestion").toggle_auto_trigger()
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

local code_companion_config = {
  "olimorris/codecompanion.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "hrsh7th/nvim-cmp",
    "nvim-telescope/telescope.nvim",
    "zbirenbaum/copilot.lua",
    "echasnovski/mini.diff",
  },
  cmd = {
    "CodeCompanion",
    "CodeCompanionChat",
    "CodeCompanionToggle",
    "CodeCompanionActions",
    "CodeCompanionAdd",
  },
  keys = {
    {
      "<C-a>",
      ":CodeCompanion /buffer ",
      mode = { "n", "v" },
      desc = "Call code companion",
    },
    {
      "<leader>aa",
      "<cmd>CodeCompanionToggle<cr>",
      desc = "Show Code Companion chat",
      mode = { "n", "v" },
    },
  },

  config = function()
    local companion = "ollama"

    local stat =
      vim.uv.fs_stat(vim.fn.expand("~/.config/github-copilot/hosts.json"))
    if stat ~= nil then
      companion = "copilot"
    end

    if vim.g.code_companion then
      companion = vim.g.code_companion
    end

    local config = vim.tbl_deep_extend("force", {
      strategies = {
        chat = {
          adapter = companion,
        },
        inline = {
          adapter = companion,
        },
        agent = {
          adapter = companion,
        },
      },
    }, vim.g.code_companion_config or {})

    require("codecompanion").setup(config)
  end,
}

return {
  copilot_config,
  code_companion_config,
}
