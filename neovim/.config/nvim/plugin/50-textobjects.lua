-- various textobjects
-- https://github.com/chrisgrieser/nvim-various-textobjs

require("_.pack").add(
  "https://github.com/chrisgrieser/nvim-various-textobjs",
  nil,
  function()
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
  true
)
