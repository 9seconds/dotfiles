-- git blame
-- https://github.com/FabijanZulj/blame.nvim

return {
  "FabijanZulj/blame.nvim",
  cmd = "BlameToggle",
  keys = {
    {
      "<leader>gb",
      "<cmd>BlameToggle window<cr>",
      desc = "Git blame as window",
    },
  },

  opts = {
    blame_options = { "-w" },
  },
}
