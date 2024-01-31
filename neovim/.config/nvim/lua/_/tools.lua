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
  M.configs.lsp[server_name] = opts or {}
end

function M.fmt(name, filetypes, opts)
  local fmts = M.configs.formatters

  fmts.settings[name] =
    vim.tbl_deep_extend("force", fmts.settings[name] or {}, opts or {})

  for _, value in ipairs(filetypes or {}) do
    if fmts.filetypes[value] == nil then
      fmts.filetypes[value] = {}
    end
    table.insert(fmts.filetypes[value], name)
  end
end

function M.lint(name, filetypes, opts)
  local lnt = M.configs.linters

  lnt.settings[name] =
    vim.tbl_deep_extend("force", lnt.settings[name] or {}, opts or {})

  for _, value in ipairs(filetypes or {}) do
    if lnt.filetypes[value] == nil then
      lnt.filetypes[value] = {}
    end
    table.insert(lnt.filetypes[value], name)
  end
end

return M
