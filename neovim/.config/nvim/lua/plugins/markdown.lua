-- nice markdown rendering
-- https://github.com/MeanderingProgrammer/render-markdown.nvim

return {
  "MeanderingProgrammer/render-markdown.nvim",
  version = "*",
  ft = {
    "markdown",
    "codecompanion",
  },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },

  opts = {
    render_modes = true,
    sign = {
      enabled = false,
    },
    completions = {
      blink = {
        enabled = true,
      },
    },
  },
}
