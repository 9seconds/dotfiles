-- better sorting
-- https://github.com/sQVe/sort.nvim

return {
  "sQVe/sort.nvim",
  keys = {
    {
      "<leader>S",
      "<cmd>Sort i<cr>",
      mode = { "v" },
      desc = "Sort lines",
    },
  },
  cmd = "Sort",

  opts = {},
}
