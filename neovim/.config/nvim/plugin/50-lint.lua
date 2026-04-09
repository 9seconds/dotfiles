-- linters
-- https://github.com/mfussenegger/nvim-lint

require("_.pack").add({
  url = "https://github.com/mfussenegger/nvim-lint",
  config = function()
    local mod = require("lint")
    local augroup = vim.api.nvim_create_augroup("9_Lint", {})

    local function get_linters()
      local ft = vim.bo.filetype

      return vim.iter(pairs(mod.linters_by_ft)):fold({}, function(acc, k, v)
        if k == "*" or k == ft then
          vim.list_extend(acc, v)
        end
        return acc
      end)
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
  end,
})
