-- support for tags
-- https://github.com/ludovicchabant/vim-gutentags


return {
  "ludovicchabant/vim-gutentags",
  dependencies = {
    "ahmedkhalf/project.nvim"
  },
  event = "VeryLazy",

  config = function()
    vim.g.gutentags_cache_dir = vim.fn.expand("~/.cache/gutentags")

    if vim.fn.executable("fd") then
      vim.g.gutentags_file_list_command = "fd --type f --full-path --color never ."
    end

    vim.g.gutentags_add_default_project_roots = false
    vim.g.gutentags_project_root = {
      "Makefile",
      "go.mod",
      ".git",
      "package.json"
    }
  end
}
