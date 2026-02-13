-- flash as a modern leap
-- https://github.com/folke/flash.nvim

local function make_smart_case(value)
  if value:find("%n") then
    return value .. "\\C"
  end
  return value .. "\\c"
end

return {
  "folke/flash.nvim",
  version = "*",
  keys = {
    {
      "s",
      function()
        return require("flash").jump({
          search = {
            mode = make_smart_case,
          },
        })
      end,
      mode = { "n", "x", "o" },
      desc = "Flash: Jump to the label",
    },
    {
      "S",
      function()
        return require("flash").jump({
          search = {
            mode = function(str)
              return make_smart_case("\\<" .. str)
            end,
          },
        })
      end,
      mode = { "n", "x", "o" },
      desc = "Flash: Jump searching only for beginning",
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
  },

  opts = {
    search = {
      incremental = true,
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
        jump_labels = true,
      },
    },
    remote_op = {
      restore = true,
      motion = true,
    },
  },
}
