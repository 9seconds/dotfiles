-- pretty quickfix
-- https://github.com/stevearc/quicker.nvim

vim.pack.add({
  "https://github.com/stevearc/quicker.nvim",
})

local mod = require("quicker")
local keymap = require("_.utils").keymap("Quicker", "<leader>q")

mod.setup({
  keys = {
    {
      ">",
      function ()
        mod.expand({
          before = 2,
          after = 2,
          add_to_existing = true,
        })
      end,
      desc = "Expand quickfix context",
    },
    {
      "<",
      function ()
        mod.collapse()
      end,
      desc = "Collapse quickfix context",
    },
  },
})

keymap("Toggle quickfix", "q", mod.toggle)
keymap("Toggle loclist", "l", function () mod.toggle({ loclist = true }) end)
