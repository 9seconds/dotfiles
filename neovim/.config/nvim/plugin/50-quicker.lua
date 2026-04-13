-- pretty quickfix
-- https://github.com/stevearc/quicker.nvim

vim.pack.add({
  "https://github.com/stevearc/quicker.nvim",
})

local function keymap(key, name, func)
  vim.keymap.set("n", "<leader>q" .. key, func, {
    desc = "Quicker: " .. name,
  })
end

require("quicker").setup({
  keys = {
    {
      ">",
      function()
        require("quicker").expand({
          before = 2,
          after = 2,
          add_to_existing = true,
        })
      end,
      desc = "Expand quickfix context",
    },
    {
      "<",
      function()
        require("quicker").collapse()
      end,
      desc = "Collapse quickfix context",
    },
  },
})

keymap("q", "Toggle quickfix", function()
  require("quicker").toggle()
end)

keymap("q", "Toggle loclist", function()
  require("quicker").toggle({ loclist = true })
end)
