-- automatic indentation guessing
-- https://github.com/NMAC427/guess-indent.nvim

require("_.pack").add(
  "https://github.com/NMAC427/guess-indent.nvim",
  nil,
  function()
    require("guess-indent").setup()
  end
)
