local lsp = require("_.lsp")
local nonels = require("_.none-ls")

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
nonels:add_diagnostic("gitlint")
nonels:add_diagnostic("mypy")
nonels:add_diagnostic("selene")
nonels:add_formatting("stylua")
