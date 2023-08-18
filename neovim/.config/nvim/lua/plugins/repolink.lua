-- create http permalinks
-- https://github.com/9seconds/repolink.nvim

return {
  "9seconds/repolink.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  cmd = { "RepoLink" },

  opts = {},
}
