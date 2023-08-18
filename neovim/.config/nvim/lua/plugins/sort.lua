-- better sorting
-- https://github.com/sQVe/sort.nvim

return {
  "sQVe/sort.nvim",
  keys = {
    {
      "<leader>s",
      ":Sort i<cr>",
      mode = { "v" },
      desc = "Sort lines",
    },
  },
  cmd = "Sort",

  opts = {},
}
