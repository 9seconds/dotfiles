-- colorful menu for blink
-- https://github.com/xzbdmw/colorful-menu.nvim

require("_.pack").add({
  url = "https://github.com/xzbdmw/colorful-menu.nvim",
  config = function()
    require("colorful-menu").setup({})
  end
})
