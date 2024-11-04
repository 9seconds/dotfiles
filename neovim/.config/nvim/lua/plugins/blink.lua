-- autocompletion
-- https://github.com/Saghen/blink.cmp


return {
  "Saghen/blink.cmp",
  version = "*",

  opts = {
    keymap = {preset = "enter"},
    nerd_font_variant = "mono",
    highlight = {
      use_nvim_cmp_as_default = true,
    },
    sources = {
      enabled_providers = {

        "lsp",
         "path",
        "buffer"
      }
    },
    window = {
      autocomplete = {
        selection = "auto_insert"
      }
    }

  }
}
