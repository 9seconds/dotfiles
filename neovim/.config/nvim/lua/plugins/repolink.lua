-- create http permalinks
-- https://github.com/9seconds/repolink.nvim

return {
  "9seconds/repolink.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "ahmedkhalf/project.nvim",
  },
  cmd = { "RepoLink" },

  opts = {},
}
