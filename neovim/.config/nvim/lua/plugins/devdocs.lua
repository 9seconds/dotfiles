-- devdocs.io integration
-- https://github.com/luckasRanarison/nvim-devdocs

return {
  "luckasRanarison/nvim-devdocs",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  cmd = {
    "DevdocsFetch",
    "DevdocsInstall",
    "DevdocsUninstall",
    "DevdocsOpen",
    "DevdocsOpenFloat",
    "DevdocsOpenCurrent",
    "DevdocsOpenCurrentFloat",
    "DevdocsUpdate",
    "DevdocsUpdateAll",
  },
  keys = {
    {
      "<leader>td",
      "<cmd>DevdocsOpen<cr>",
      desc = "Open DevDocs",
    },
  },

  opts = {
    previewer_cmd = "glow",
    cmd_args = { "-l", "-s", "dark", "-w", "80" },
    picker_cmd = true,
    picker_cmd_args = { "-l", "-p" },
  },
}
