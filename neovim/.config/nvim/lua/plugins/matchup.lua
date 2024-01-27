-- better matching of pairs
-- https://github.com/andymass/vim-matchup


return {
  "andymass/vim-matchup",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },

  config = function()
    vim.g.matchup_matchparen_offscreen = {
      method = "popup",
    }
  end,

  init = function()
    vim.g.loaded_matchit = 1
  end
}
