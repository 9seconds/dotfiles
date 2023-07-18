-- autoclose forgotten buffers
-- https://github.com/chrisgrieser/nvim-early-retirement


return {
  "chrisgrieser/nvim-early-retirement",
  event = "VeryLazy",
  main = "early-retirement",

  opts = {
    retirementAgeMins = 30,
    minimumBufferNum = 5,
  }
}
