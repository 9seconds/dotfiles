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
      { "k", rules = { await = 1000, on_repeat = 10 } },
      { "j", rules = { await = 1000, on_repeat = 10 } },
    },
  }
)
