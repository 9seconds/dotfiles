-- surround plugin
-- https://github.com/nvim-mini/mini.surround

vim.pack.add({
  {
    src = "https://github.com/nvim-mini/mini.surround",
    version = vim.version.range("*"),
  },
})

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
