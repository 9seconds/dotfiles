-- various textobjects
-- https://github.com/chrisgrieser/nvim-various-textobjs

require("_.pack").add({
  url = "https://github.com/chrisgrieser/nvim-various-textobjs",
  lazy = true,
  config = function()
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
  end,
})
