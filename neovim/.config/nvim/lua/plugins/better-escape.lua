-- hacks around escape
-- https://github.com/max397574/better-escape.nvim

return {
  "max397574/better-escape.nvim",
  event = "InsertEnter",
  main = "better_escape",

  opts = {
    mapping = { "jj", "kk" },
  },
}
