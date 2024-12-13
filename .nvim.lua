local conform = require("_.conform")
local lint = require("_.lint")
local lsp = require("_.lsp")

lsp:set("basedpyright", {
  handlers = {
    ["textDocument/publishDiagnostics"] = function() end,
  },
  settings = {
    pyright = {
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        diagnosticMode = "openFilesOnly",
        typeCheckingMode = "off",
        autoSearchPaths = false,
      },
    },
  },
})
lsp:set("ruff")
lsp:set("lua_ls", {
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
})
conform:set("lua", "stylua")
lint:set("python", "mypy")
lint:set("python", "ruff")
lint:set("lua", "typos")
lint:set("python", "typos")
lint:set("lua", "selene")
