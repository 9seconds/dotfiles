-- highlight mentioned range
-- https://github.com/winston0410/range-highlight.nvim

return {
  "winston0410/range-highlight.nvim",
  dependencies = {
    "winston0410/cmd-parser.nvim",
  },
  event = "CmdlineEnter",

  opts = {},
}
