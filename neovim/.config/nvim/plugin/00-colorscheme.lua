-- colorscheme
-- https://github.com/Aejkatappaja/cendre
-- https://cendretheme.com/
--
-- previous:
--   -- https://github.com/webhooked/kanso.nvim

vim.pack.add({
  {
    src = "https://github.com/Aejkatappaja/cendre",
    version = vim.version.range("*"),
  },
})

require("cendre").setup({
  background = "medium",
})

vim.cmd("colorscheme cendre")
