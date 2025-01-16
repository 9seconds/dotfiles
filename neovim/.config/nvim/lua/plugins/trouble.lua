-- diagnostic framework that makes a lot of sense
-- https://github.com/folke/trouble.nvim

return {
  "folke/trouble.nvim",
  keys = {
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Open loclist with diagnostic",
    },
    {
      "<leader>xa",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Open loclist with diagnostic",
    },
  },
  cmd = {
    "Trouble",
  },

  opts = {},
}
