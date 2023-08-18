-- diagnostics wrapper
-- https://github.com/folke/trouble.nvim

return {
  "folke/trouble.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    {
      "<leader>xx",
      function()
        require("trouble").toggle()
      end,
      desc = "Toggle diagnostics",
    },
    {
      "<leader>xw",
      function()
        require("trouble").toggle("workspace_diagnostics")
      end,
      desc = "Toggle workspace diagnostics",
    },
    {
      "<leader>xd",
      function()
        require("trouble").toggle("document_diagnostics")
      end,
      desc = "Toggle document diagnostics",
    },
    {
      "<leader>xq",
      function()
        require("trouble").toggle("quickfix")
      end,
      desc = "Toggle quickfix",
    },
    {
      "<leader>xl",
      function()
        require("trouble").toggle("loclist")
      end,
      desc = "Toggle location list",
    },
  },

  opts = {},
}
