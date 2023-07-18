-- fast movements
-- https://github.com/ggandor/leap.nvim


return {
  "ggandor/leap.nvim",
  dependencies = {
    "tpope/vim-repeat"
  },
  event = "VeryLazy",

  config = function()
    require('leap').add_default_mappings()
  end
}
