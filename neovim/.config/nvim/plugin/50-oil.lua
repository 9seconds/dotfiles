-- file buffer manager
-- https://github.com/stevearc/oil.nvim

vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1

vim.pack.add({
  {
    src = "https://github.com/stevearc/oil.nvim",
    version = vim.version.range("*"),
  },
})

local mod = require("oil")
local keymap = require("_.utils").keymap("Oil")

mod.setup({
  columns = {
    "icon",
    "permissions",
    "size",
  },
  keymaps = {
    ["<C-h>"] = false,
    ["<C-l>"] = false,
    ["<C-x>"] = "actions.select_split",
  },
})

keymap("Open", "-", mod.open)
