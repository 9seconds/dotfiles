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
        return require("flash").jump({ continue = true })
      end,
      mode = { "n", "x", "o" },
      desc = "Jump with flash",
    },
    {
      "T",
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
    {
      "s",
      function()
        require("flash").remote()
      end,
      mode = "o",
      desc = "Run flash in remote mode",
    },
    -- these are mappings for clever-f
    "f",
    "F",
    "t",
    "T",
    ";",
    ",",
  },

  opts = {
    search = {
      incremental = true,
      mode = function(str)
        return "\\<" .. str
      end,
    },
    jump = {
      pos = "end",
      autojump = true,
    },
    label = {
      uppercase = false,
    },
    modes = {
      char = {
        enabled = true,
        jump_labels = true,
      },
    },
    remote_op = {
      restore = true,
      motion = true,
    },
  },
}
