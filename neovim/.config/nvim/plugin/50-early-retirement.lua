-- autoclose forgotten buffers
-- https://github.com/chrisgrieser/nvim-early-retirement

require("_.pack").add({
  url = "https://github.com/chrisgrieser/nvim-early-retirement",
  lazy = true,
  config = function()
    require("early-retirement").setup({
      retirementAgeMins = 30,
      minimumBufferNum = 5,
    })
  end,
})
