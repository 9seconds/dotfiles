-- nice markdown rendering
-- https://github.com/MeanderingProgrammer/render-markdown.nvim

return {
  "MeanderingProgrammer/render-markdown.nvim",
  version = "*",
  ft = {
    "markdown",
    "copilot-chat",
  },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },

  opts = {
    file_types = {
      "markdown",
      "copilot-chat",
    },
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
