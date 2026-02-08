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
      desc = "Flash: Jump to the label",
    },
    {
      "S",
      function()
        return require("flash").jump({
          jump = { pos = "start" },
        })
      end,
      mode = { "n", "x", "o" },
      desc = "Flash: Jump to the start",
    },
    {
      "gs",
      function()
        return require("flash").jump({ continue = true })
      end,
      mode = { "n", "x", "o" },
      desc = "Flash: Continue",
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
        if str:find("%u") then
          return "\\<" .. str .. "\\C"
        end
        return "\\<" .. str .. "\\c"
      end,
    },
    jump = {
      pos = "end",
      autojump = true,
    },
    label = {
      uppercase = false,
      rainbox = {
        enabled = true,
      },
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
