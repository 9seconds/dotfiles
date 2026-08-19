-- neogit
-- https://github.com/neogitorg/neogit

vim.pack.add({
  "https://github.com/neogitorg/neogit",
})

vim.keymap.set(
  "n", "<leader>gg",
  function ()
    require("neogit").open()
  end,
  {
    desc = "Neogit: Open",
  }
)
