-- neogit
-- https://github.com/neogitorg/neogit

vim.pack.add({
  "https://github.com/neogitorg/neogit",
})

require("neogit").setup({
  integrations = {
    codediff = true,
    fzf_lua = true,
    snacks = false,
    mini_pick = false,
  }
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
