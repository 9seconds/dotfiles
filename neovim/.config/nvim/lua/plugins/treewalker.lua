-- wander over treesitter nodes
-- https://github.com/aaronik/treewalker.nvim

return {
  "aaronik/treewalker.nvim",
  keys = {
    {
      "H",
      "<cmd>Treewalker Left<cr>",
      desc = "Go to ancestor"
    },
    {
      "J",
      "<cmd>Treewalker Down<cr>",
      desc = "Go to next neighbor node"
    },
    {
      "K",
      "<cmd>Treewalker Up<cr>",
      desc = "Go to previous neighbor node"
    },
    {
      "L",
      "<cmd>Treewalker Right<cr>",
      desc = "Dive into treesitter"
    },
  },
  cmd = {
    "Treewalker"
  },

  opts = {},
}
