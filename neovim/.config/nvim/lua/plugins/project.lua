-- configure project settings
-- https://github.com/ahmedkhalf/project.nvim

return {
  "ahmedkhalf/project.nvim",
  event = "VeryLazy",
  main = "project_nvim",

  opts = {
    detection_methods = { "pattern", "lsp" },
    patterns = { ".git", "Makefile", "package.json", "go.mod" },
  },
}
