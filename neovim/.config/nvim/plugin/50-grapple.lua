-- fast switch between important files
-- https://github.com/cbochs/grapple.nvim

local PRUNE_EACH = "7d"

vim.pack.add({
  {
    src = "https://github.com/cbochs/grapple.nvim",
    version = vim.version.range("*"),
  },
})

local mod = require("grapple")

mod.setup({
  scope = "git_branch",
})

mod.prune({
  limit = PRUNE_EACH,
})

vim.keymap.set(
  "n", "ga",
  function ()
    mod.toggle()
    if mod.exists() then
      vim.notify("Grappled")
    else
      vim.notify("Ungrappled")
    end
  end,
  {
    desc = "Grapple: Toggle",
  }
)

vim.keymap.set(
  "n", "gk",
  function ()
    mod.cycle_tags("prev")
  end,
  {
    desc = "Grapple: Prev tag",
  }
)

vim.keymap.set(
  "n", "gj",
  function ()
    mod.cycle_tags("next")
  end,
  {
    desc = "Grapple: Next tag",
  }
)

vim.keymap.set(
  "n", "gl",
  function ()
    mod.toggle_tags()
  end,
  {
    desc = "Grapple: Choose tag",
  }
)
