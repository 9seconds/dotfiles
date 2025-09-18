-- better matching of pairs
-- https://github.com/andymass/vim-matchup

return {
  "andymass/vim-matchup",
  event = { "BufReadPre", "BufNewFile" },
  main = "match-up",

  opts = {},

  init = function()
    vim.g.loaded_matchit = 1
    vim.g.matchup_matchparen_offscreen = {
      method = "popup",
    }
    vim.g.matchup_treesitter_stopline = 500
  end,
}
