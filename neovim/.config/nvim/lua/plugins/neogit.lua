-- git integraion
-- https://github.com/NeogitOrg/neogit

return {
  "NeogitOrg/neogit",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    "folke/snacks.nvim",
  },
  cmd = {
    "Neogit",
  },
  keys = {
    {
      "<leader>gg",
      function()
        require("neogit").open()
      end,
      desc = "Run Neogit",
    },
  },

  opts = {
    integrations = {
      snacks = true,
      diffview = true,
    },
  },
}
