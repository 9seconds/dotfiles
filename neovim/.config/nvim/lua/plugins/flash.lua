-- flash as a modern leap
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
      desc = "Jump with flash",
    },
    {
      "S",
      function()
        return require("flash").treesitter()
      end,
      mode = { "n", "x", "o" },
      desc = "Select treesitter with flash",
    },
    {
      "<c-s>",
      function()
        require("flash").toggle()
      end,
      mode = "c",
      desc = "Switch flash search mode",
    },
  },

  opts = {},
}
