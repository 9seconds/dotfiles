-- automatic indentation guessing
-- https://github.com/NMAC427/guess-indent.nvim

require("_.pack").add({
  url = "https://github.com/NMAC427/guess-indent.nvim",
  config = function()
    require("guess-indent").setup()
  end
})
