-- surround plugin
-- https://github.com/nvim-mini/mini.surround

require("_.pack").add({
  url = "https://github.com/nvim-mini/mini.surround",
  releases = true,
  lazy = true,
  config = function()
    require("mini.surround").setup({
      mappings = {
        add = "gsa",
        delete = "gsd",
        find = "gsf",
        find_left = "gsF",
        highlight = "gsh",
        replace = "gsc",
        update_n_lines = "gsn",
      },
    })
  end,
})
