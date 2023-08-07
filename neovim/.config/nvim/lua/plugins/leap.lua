-- fast movements

-- https://github.com/ggandor/leap.nvim
local leap_config = {
  "ggandor/leap.nvim",
  dependencies = {
    "tpope/vim-repeat"
  },
  event = "VeryLazy",

  config = function()
    require("leap").add_default_mappings()
  end
}

-- https://github.com/ggandor/flit.nvim
local flit_config = {
  "ggandor/flit.nvim",
  dependencies = {
    "ggandor/leap.nvim",
  },
  event = "VeryLazy",

  opts = {}
}


return {
  leap_config,
  flit_config,
}
