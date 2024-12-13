-- various textobjects
-- https://github.com/chrisgrieser/nvim-various-textobjs

return {
  "chrisgrieser/nvim-various-textobjs",
  event = "VeryLazy",

  opts = {
    keymaps = {
      useDefaults = true
    },
    textobjs = {
      subword = {
        noCamelToPascalCase = false
      }
    }
  }
}
