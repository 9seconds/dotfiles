-- matchup
-- https://github.com/andymass/vim-matchup


return {
  "andymass/vim-matchup",
  event = "VeryLazy",

  config = function()
    vim.g.matchup_transmute_enabled = 0
    vim.g.matchup_text_obj_enabled = 0
  end
}
