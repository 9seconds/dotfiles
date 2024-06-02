-- LSP configuration for mason
-- https://github.com/williamboman/mason.nvim

local mason = {
  "williamboman/mason.nvim",
  version = "*",
  build = ":MasonUpdate",

  opts = {
    pip = {
      upgrade_pip = true,
    },
    ui = {
      check_outdated_packages_on_open = false,
    },
  },
}

-- :MasonToolsUpdateSync command
-- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
local tool_installer = {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  dependencies = {
    "williamboman/mason.nvim",
  },
  cmd = {
    "MasonToolsInstall",
    "MasonToolsInstallSync",
    "MasonToolsUpdate",
    "MasonToolsUpdateSync",
    "MasonToolsClean",
  },

  opts = {
    ensure_installed = {
      "gitlint",
      "lua-language-server",
      "selene",
      "shellcheck",
      "stylua",
    },
    auto_update = true,
    run_on_start = false,
  },
}

return {
  mason,
  tool_installer,
}
