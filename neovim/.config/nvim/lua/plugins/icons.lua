-- different icons niceties

local function flatten_pallete(tbl)
  local rv = vim.iter(tbl):map(function(_, v)
    if type(v) == "table" then
      return flatten_pallete(v)
    end
    return v
  end):totable()
  return vim.iter(vim.tbl_values(rv)):flatten():totable()
end

-- development icons
-- https://github.com/nvim-tree/nvim-web-devicons
local devicons = {
  "nvim-tree/nvim-web-devicons",
  event = { "VeryLazy" },

  opts = {},
}

-- automatically adjust icon colors
-- https://github.com/rachartier/tiny-devicons-auto-colors.nvim
local color_fix = {
  "rachartier/tiny-devicons-auto-colors.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "folke/tokyonight.nvim",
  },
  event = { "VeryLazy" },

  config = function()
    require("tiny-devicons-auto-colors").setup({
      colors = flatten_pallete(require("tokyonight.colors.storm")),
    })
  end,
}

return {
  devicons,
  color_fix,
}
