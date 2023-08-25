-- devdocs.io integration
-- https://github.com/luckasRanarison/nvim-devdocs

local opts = {}
if vim.fn.executable("glow") then
  opts = {
    previewer_cmd = "glow",
    cmd_args = { "-l", "-s", "dark", "-w", "80" },
    picker_cmd = true,
    picker_cmd_args = { "-l", "-p" },
  }
end

opts.ensure_installed = {
  "bash",
  "git",
  "lua-5.1",
  "http",
  "go",
  "python-2.7",
  "python-3.11",
}

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

  opts = opts,
}
