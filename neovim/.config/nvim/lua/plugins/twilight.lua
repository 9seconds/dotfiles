-- concentrate on some block of code
-- https://github.com/folke/twilight.nvim

return {
  "folke/twilight.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  cmd = {
    "Twilight",
    "TwilightEnable",
    "TwilightDisable"
  },

  opts = {},
}
