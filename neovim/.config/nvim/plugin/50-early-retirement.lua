-- autoclose forgotten buffers
-- https://github.com/chrisgrieser/nvim-early-retirement

require("_.pack").add(
  "https://github.com/chrisgrieser/nvim-early-retirement",
  nil,
  function()
    require("early-retirement").setup({
      retirementAgeMins = 30,
      minimumBufferNum = 5,
    })
  end,
  true
)
