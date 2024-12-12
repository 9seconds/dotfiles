-- LSP configuration for mason
-- https://github.com/williamboman/mason.nvim

local mason = {
  "williamboman/mason.nvim",
  version = "*",
  build = "<cmd>MasonUpdate<cr>",

  opts = {
    pip = {
      upgrade_pip = true,
    },
    ui = {
      check_outdated_packages_on_open = false,
    },
  },
}

return {
  mason,
}
