-- better matching of pairs
-- https://github.com/andymass/vim-matchup

vim.g.loaded_matchit = 1
vim.g.matchup_matchparen_offscreen = {
  method = "popup",
}
vim.g.matchup_treesitter_stopline = 500

require("_.pack").add(
  "https://github.com/andymass/vim-matchup",
  nil,
  function()
    require("match-up").setup({})
  end
)
