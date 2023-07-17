-- better sorting
-- https://github.com/sQVe/sort.nvim

return {
  "sQVe/sort.nvim",
  keys = {
    {"<leader>S", ":Sort in<cr>", mode = {"v", "n", "x"}}
  },
  cmd = "Sort",

  opts = {}
}
