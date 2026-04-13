-- better matching of pairs
-- https://github.com/andymass/vim-matchup

vim.g.loaded_matchit = 1
vim.g.matchup_matchparen_offscreen = {
  method = "popup",
}
vim.g.matchup_treesitter_stopline = 500

vim.pack.add({
  "https://github.com/andymass/vim-matchup",
})

require("match-up").setup({})
