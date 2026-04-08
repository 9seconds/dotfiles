-- surround plugin
-- https://github.com/nvim-mini/mini.surround

require("_.pack").add(
  "https://github.com/nvim-mini/mini.surround",
  vim.version.range("*"),
  function()
    require("mini.surround").setup({
      mappings = {
      add = "gsa",
      delete = "gsd",
      find = "gsf",
      find_left = "gsF",
      highlight = "gsh",
      replace = "gsc",
      update_n_lines = "gsn",
      }
    })
  end,
  true
)
