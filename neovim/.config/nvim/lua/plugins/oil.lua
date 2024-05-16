-- file buffer manager
-- https://github.com/stevearc/oil.nvim

return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    {
      "-",
      function()
        require("oil").open()
      end,
      mode = { "n" },
      desc = "Open directory with Oil",
    },
    {
      "<leader>-",
      function()
        require("oil").open_float()
      end,
      mode = { "n" },
      desc = "Open directory with Oil within a floating window",
    },
  },
  cmd = "Oil",

  opts = {
    columns = {
      "icon",
      "permissions",
      "size",
    },
    keymaps = {
      ["<C-h>"] = false,
      ["<C-l>"] = false,
      ["<C-x>"] = "actions.select_split",
    },
  },

  init = function()
    vim.g.loaded_netrwPlugin = 1
    vim.g.loaded_netrw = 1
  end,
}
