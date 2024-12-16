-- zen modes
-- https://github.com/pocco81/true-zen.nvim

local ZEN_SETTINGS = {
  number = false,
  signcolumn = "no",
  colorcolumn = "",
}

local twilight_config = {
  "folke/twilight.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  cmd = {
    "Twilight",
    "TwilightEnable",
    "TwilightDisable",
  },

  opts = {
    context = 15,
    treesitter = true,
  },
}

local zen_mode_config = {
  "folke/zen-mode.nvim",
  dependencies = {
    "folke/twilight.nvim",
  },
  cmd = {
    "ZenMode",
  },
  keys = {
    {
      "<leader>z",
      function()
        require("zen-mode").toggle()
      end,
      desc = "Toggle Zen mode",
    },
  },

  opts = function()
    return {
      window = {
        width = 0.6,
      },
      plugins = {
        twilight = {
          enabled = true,
        },
        kitty = {
          enabled = os.getenv("KITTY_LISTEN_ON") ~= nil,
          font = "+4",
        },
        tmux = {
          enabled = os.getenv("TMUX") ~= nil,
        },
        gitsigns = {
          enabled = false,
        },
      },

      on_open = function()
        local old_zen = {}
        vim.w.__old_zen = old_zen

        for key, value in pairs(ZEN_SETTINGS) do
          old_zen[key] = vim.wo[key]
          vim.wo[key] = value
        end
      end,

      on_close = function()
        for key, value in pairs(vim.w.__old_zen or {}) do
          vim.wo[key] = value
        end
      end,
    }
  end,
}

return {
  twilight_config,
  zen_mode_config,
}
