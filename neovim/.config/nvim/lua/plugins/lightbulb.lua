-- vscode bulb
-- https://github.com/kosayoda/nvim-lightbulb

return {
  "kosayoda/nvim-lightbulb",
  event = { "LspAttach" },

  opts = {
    autocmd = {
      enabled = true,
    },
    sign = {
      enabled = false,
    },
    virtual_text = {
      enabled = false,
    },
  },
}
