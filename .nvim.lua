local conform = require("_.conform")
conform:set("lua", "stylua")

local lint = require("_.lint")
lint:set("python", "mypy")
lint:set("python", "ruff")
lint:set("lua", "selene")

local lsp = require("_.lsp")
lsp.enable({
  "basedpyright",
  "bash-language-server",
  "lua-language-server",
  "typos-lsp",
})
