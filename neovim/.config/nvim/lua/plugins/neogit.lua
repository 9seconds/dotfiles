-- git
-- https://github.com/NeogitOrg/neogit

return {
  "NeogitOrg/neogit",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    "nvim-telescope/telescope.nvim",
  },
  keys = {
    {
      "<leader>gg",
      function()
        require("neogit").open({
          kind = "auto",
        })
      end,
      desc = "Neogit status",
    },
  },
  cmd = {
    "Neogit",
  },

  opts = function()
    return {
      graph_style = os.getenv("KITTY_PUBLIC_KEY") and "kitty" or "unicode",
    }
  end,
}
