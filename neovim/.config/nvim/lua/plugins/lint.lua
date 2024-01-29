-- neovim linters
-- https://github.com/mfussenegger/nvim-lint


return {
  "mfussenegger/nvim-lint",
  event = "BufWritePre",

  config = function()
    local tools = require("_.tools")
    local lint = require("lint")

    lint.linters_by_ft = tools.configs.linters.filetypes
    for name, config in pairs(tools.configs.linters.settings) do
      lint.linters[name] = vim.tbl_extend(
        "force",
        lint.linters[name] or {},
        config or {}
      )
    end

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      group = vim.api.nvim_create_augroup("9_Lint", {}),
      callback = function()
        lint.try_lint()
      end
    })
  end
}
