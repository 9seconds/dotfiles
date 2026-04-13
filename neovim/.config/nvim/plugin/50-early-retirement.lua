-- autoclose forgotten buffers
-- https://github.com/chrisgrieser/nvim-early-retirement

vim.pack.add({
  "https://github.com/chrisgrieser/nvim-early-retirement",
})

require("early-retirement").setup({
  retirementAgeMins = 30,
  minimumBufferNum = 5,
})
