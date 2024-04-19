-- hop between treesitter nodes
-- https://github.com/xiaoshihou514/squirrel.nvim

return {
  "xiaoshihou514/squirrel.nvim",
  keys = {
    {
      "gh",
      function()
        require("squirrel.hop").hop_linewise({
          head = true,
          tail = false,
        })
      end,
      mode = { "n", "x" },
      desc = "Hop to the head of node linewise",
    },
    {
      "gl",
      function()
        require("squirrel.hop").hop_linewise({
          head = false,
          tail = true,
        })
      end,
      mode = { "n", "x" },
      desc = "Hop to the tail of node linewise",
    },
    {
      "gk",
      function()
        require("squirrel.hop").hop({
          head = true,
          tail = false,
        })
      end,
      mode = { "n", "x" },
      desc = "Hop to the head of node",
    },
    {
      "gj",
      function()
        require("squirrel.hop").hop({
          head = false,
          tail = true,
        })
      end,
      mode = { "n", "x" },
      desc = "Hop to the tail of node",
    },
  },
}
