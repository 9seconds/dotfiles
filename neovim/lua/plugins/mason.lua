-- LSP configuration for mason
-- https://github.com/williamboman/mason.nvim


local mason_config = {
  "williamboman/mason.nvim",
  version = "*",
  build = ":MasonUpdate",

  opts = {}
}

local mason_lspconfig = {
  "williamboman/mason-lspconfig.nvim",
  version = "*",
  dependencies = {
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig",
  },

  opts = {}
}

return {
  mason_config,
  mason_lspconfig,
}
