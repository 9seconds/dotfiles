-- various textobjects
-- https://github.com/chrisgrieser/nvim-various-textobjs

vim.pack.add({
  "https://github.com/chrisgrieser/nvim-various-textobjs",
})

require("various-textobjs").setup({
  keymaps = {
    useDefaults = true,
  },
  textobjs = {
    subword = {
      noCamelToPascalCase = false,
    },
  },
})
