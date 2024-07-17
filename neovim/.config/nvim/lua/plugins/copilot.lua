-- Copilot stuff

-- https://github.com/zbirenbaum/copilot.lua
local copilot_config = {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",

  opts = {
    panel = {
      enabled = false,
    },
    suggestion = {
      enabled = false,
    },
  },
}

local cmp_config = {
  "zbirenbaum/copilot-cmp",
  dependencies = {
    "zbirenbaum/copilot.lua",
    "onsails/lspkind.nvim",
  },

  config = function()
    require("copilot_cmp").setup()

    require("lspkind").init({
      symbol_map = {
        Copilot = "",
      },
    })

    -- https://github.com/folke/tokyonight.nvim/blob/main/lua/tokyonight/colors/storm.lua#L20
    vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#9ece6a" })
  end,
}

return {
  copilot_config,
  cmp_config,
}
