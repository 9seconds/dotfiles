-- icons
-- https://github.com/nvim-mini/mini.icons

vim.pack.add({
  {
    src = "https://github.com/nvim-mini/mini.icons",
    version = vim.version.range("*"),
  },
})

local mod = require("mini.icons")

mod.setup({})
mod.mock_nvim_web_devicons()
