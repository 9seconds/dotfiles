-- fast navigation by labels
-- https://github.com/folke/flash.nvim

return {
  "folke/flash.nvim",
  version = "*",
  keys = {
    {
      "s",
      function()
        return require("flash").jump()
      end,
      mode = { "n", "x", "o" },
      desc = "Flash: Jump everywhere",
    },
    {
      "S",
      function()
        return require("flash").treesitter_search()
      end,
      mode = { "n", "x", "o" },
      desc = "Flash: Jump treesitter",
    },
    {
      "<c-s>",
      function()
        return require("flash").toggle()
      end,
      mode = "c",
      desc = "Flash: Fuzzy search",
    },
  },

  opts = {
    search = {
      mode = "fuzzy",
    },
    jump = {
      nohlsearch = true,
      autojump = false,
    },
    label = {
      uppercase = false,
      rainbow = {
        enabled = true,
      },
    },
  },
}
