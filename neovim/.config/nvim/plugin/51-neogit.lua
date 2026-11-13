-- neogit
-- https://github.com/neogitorg/neogit

vim.pack.add({
  "https://github.com/neogitorg/neogit",
})

local mod = require("neogit")
local keymap = require("_.utils").keymap("Neogit", "<leader>g")

mod.setup({
  integrations = {
    fzf_lua = true,
    snacks = false,
    mini_pick = false,
  },
})

keymap("Open", "g", mod.open)
