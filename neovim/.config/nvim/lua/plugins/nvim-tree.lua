-- file explorer
-- https://github.com/nvim-tree/nvim-tree.lua/


return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "ahmedkhalf/project.nvim"
  },
  keys = {
    {
      "<leader>ee",
      "<cmd>NvimTreeToggle<cr>",
    },
    {
      "<leader>ef",
      "<cmd>NvimTreeFindFile<cr>"
    }
  },

  init = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    vim.o.termguicolors = true
  end,

  opts = {
    disable_netrw = true,
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    renderer = {
      highlight_git = true,
      highlight_modified = "name",
    },
    view = {
      width = 40,
    },
    git = {
      timeout = 2000,
    },
    modified = {
      enable = true,
    },
    filters = {
      dotfiles = true,
    },
  }
}
