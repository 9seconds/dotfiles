local conform = require("_.conform")
local lint = require("_.lint")

vim.g.lsp_configs = {
  -- lua
  ["lua-language-server"] = {
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
        },
        workspace = {
          checkThirdParty = false,
          library = vim.api.nvim_get_runtime_file("", true),
        },
      },
    },
  },
}

conform:set("lua", "stylua")

lint:set("python", "mypy")
lint:set("python", "ruff")
lint:set("*", "typos")
lint:set("lua", "selene")

vim.lsp.enable({
  "lua-language-server",
  "basedpyright",
})
