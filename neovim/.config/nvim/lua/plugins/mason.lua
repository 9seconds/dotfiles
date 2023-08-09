-- LSP configuration for mason
-- https://github.com/williamboman/mason.nvim


local mason_config = {
  "williamboman/mason.nvim",
  version = "*",
  build = ":MasonUpdate",

  opts = {}
}


local mason_tool_installer = {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  dependencies = {
    "williamboman/mason.nvim",
  },

  opts = {
    ensure_installed = {
      "black",
      "efm",
      "gitlint",
      "hadolint",
      "markdownlint",
      "prettier",
      "shellcheck",
      "yamllint",
    }
  }
}


return {
  mason_config,
  mason_tool_installer,
}
