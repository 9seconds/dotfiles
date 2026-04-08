-- icons
-- https://github.com/nvim-mini/mini.icons

require("_.pack").add({
  url = "https://github.com/nvim-mini/mini.icons",
  releases = true,
  lazy = true,
  config = function()
    require("mini.icons").setup()
  end,
})
