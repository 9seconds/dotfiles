-- git blame
-- https://github.com/FabijanZulj/blame.nvim

return {
  "FabijanZulj/blame.nvim",
  cmd = "BlameToggle",
  keys = {
    {
      "<leader>gb",
      "<cmd>BlameToggle virtual<cr>",
      desc = "Git blame as virtual text",
    },
  },

  opts = {
    blame_options = { "-w" },
  },
}
