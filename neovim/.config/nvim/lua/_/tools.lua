-- different LSP helpers

local M = {
  configs = {
    lsp = {},
    formatters = {
      filetypes = {},
      settings = {},
    },
    linters = {
      filetypes = {},
      settings = {},
    },
  },
}

function M.lsp(server_name, opts)
  local settings = M.configs.lsp

  settings[server_name] =
    vim.tbl_deep_extend("force", settings[server_name] or {
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
    }, opts or {})
end

function M.fmt(name, opts)
  local settings = M.configs.formatters.settings

  settings[name] =
    vim.tbl_deep_extend("force", settings[name] or {}, opts or {})
end

function M.fmt_by_ft(filetype, names)
  M.configs.formatters.filetypes[filetype] = names
end

function M.lint(name, opts)
  local settings = M.configs.linters.settings

  settings[name] =
    vim.tbl_deep_extend("force", settings[name] or {}, opts or {})
end

function M.lint_by_ft(filetype, names)
  M.configs.linters.filetypes[filetype] = names
end

return M
