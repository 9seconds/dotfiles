-- better matching of pairs
-- https://github.com/andymass/vim-matchup

vim.g.loaded_matchit = 1
vim.g.matchup_matchparen_offscreen = {
  method = "popup",
}
vim.g.matchup_treesitter_stopline = 500

require("_.pack").add({
  url = "https://github.com/andymass/vim-matchup",
  config = function()
    require("match-up").setup({})
  end
})
