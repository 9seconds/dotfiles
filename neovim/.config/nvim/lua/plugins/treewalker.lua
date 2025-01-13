-- wander over treesitter nodes
-- https://github.com/aaronik/treewalker.nvim

return {
  "aaronik/treewalker.nvim",
  keys = {
    {
      "<Left>",
      "<cmd>Treewalker Left<cr>",
      desc = "Go to ancestor",
    },
    {
      "<Down>",
      "<cmd>Treewalker Down<cr>",
      desc = "Go to next neighbor node",
    },
    {
      "<Up>",
      "<cmd>Treewalker Up<cr>",
      desc = "Go to previous neighbor node",
    },
    {
      "<Right>",
      "<cmd>Treewalker Right<cr>",
      desc = "Dive into treesitter",
    },
  },
  cmd = {
    "Treewalker",
  },

  opts = {},
}
