-- better matching of pairs
-- https://github.com/andymass/vim-matchup

return {
  "andymass/vim-matchup",

  config = function()
    vim.g.matchup_matchparen_offscreen = {
      method = "popup",
    }
  end,

  init = function()
    vim.g.loaded_matchit = 1
  end,
}
