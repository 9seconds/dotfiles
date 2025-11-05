-- git integraion
-- https://github.com/NeogitOrg/neogit

return {
  "NeogitOrg/neogit",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    "ibhagwan/fzf-lua",
    "folke/snacks.nvim",
  },
  cmd = {
    "Neogit"
  },

  opts = {}
}
