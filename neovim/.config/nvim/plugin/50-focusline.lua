-- focus where meaningful
-- https://github.com/ABDsheikho/focusline.nvim

vim.pack.add({
  "https://github.com/ABDsheikho/focusline.nvim",
})

require("focusline").setup(
  {
    focus_target = "30%", -- try it with 30%
    with_motion = {
      "zz",
      "z,",
    },
  }
)
