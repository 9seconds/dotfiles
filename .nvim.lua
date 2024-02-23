local tools = require("_.tools")

tools.lsp("pyright", {
  settings = {
    pyright = {
      disableOrganizeImports = false,
    },
    python = {
      analysis = {
        diagnosticMode = "off",
        typeCheckingMode = "off",
        autoSearchPaths = false,
      },
    },
  },
})
tools.lint("flake8", { "python" })
tools.lint("mypy", { "python" })
tools.fmt("black", { "python" })
