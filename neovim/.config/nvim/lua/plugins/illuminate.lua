-- smart cursorword
-- https://github.com/RRethy/vim-illuminate

return {
  "RRethy/vim-illuminate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  event = { "FileType" },

  config = function()
    require("illuminate").configure({
      providers = {
        "treesitter",
        "regex",
      },
      filetypes_denylist = {
        "oil",
      },
      large_file_cutoff = 8000,
      min_count_to_highlight = 2,
    })
  end,
}
