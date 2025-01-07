-- better sorting
-- https://github.com/sQVe/sort.nvim

return {
  "sQVe/sort.nvim",
  keys = {
    {
      "<leader>s",
      ":Sort ",
      mode = { "v", "n", "s" },
      desc = "Sort lines",
    },
  },
  cmd = {
    "Sort",
  },

  opts = {},
}
