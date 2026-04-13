-- linters
-- https://github.com/mfussenegger/nvim-lint

vim.pack.add({
  "https://github.com/mfussenegger/nvim-lint",
})

local mod = require("lint")
local augroup = vim.api.nvim_create_augroup("9_Lint", {})

local function get_linters()
  local ft = vim.bo.filetype

  local values = vim
    .iter(require("_.lint").configs)
    :fold({}, function(acc, k, v)
      if k == "*" or k == ft then
        vim.list_extend(acc, v)
      end
      return acc
    end)

  return vim.list.unique(values)
end

vim.api.nvim_create_autocmd("TextChanged", {
  group = augroup,
  callback = function()
    mod.try_lint(get_linters(), { filter = "stdin" })
  end,
})

vim.api.nvim_create_autocmd({ "BufWritePost", "FileType" }, {
  group = augroup,
  callback = function()
    mod.try_lint(get_linters())
  end,
})
