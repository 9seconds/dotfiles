--- linters
--- https://github.com/mfussenegger/nvim-lint

return {
  "mfussenegger/nvim-lint",
  event = {
    "FileType",
  },

  opts = {},

  config = function(_, opts)
    local conf = require("_.lint")
    local lintmod = require("lint")

    opts = vim.tbl_extend("force", opts, conf:get_config())

    lintmod.linters_by_ft = opts.linters_by_ft
    for name, config in pairs(opts.linters) do
      lintmod.linters[name] =
        vim.tbl_deep_extend("force", lintmod.linters[name] or {}, config)
    end

    local fast_linters = {}
    for lang, linters in pairs(opts.linters_by_ft) do
      fast_linters[lang] = {}

      for _, name in ipairs(linters) do
        if lintmod.linters[name].stdin then
          table.insert(fast_linters[lang], name)
        end
      end
    end

    local fast_linters_wildcard = fast_linters[conf.ALL]
    local linters_wildcard = opts.linters_by_ft[conf.ALL]
    opts.linters_by_ft[conf.ALL] = nil

    local augroup = vim.api.nvim_create_augroup("9_Lint", {})
    vim.api.nvim_create_autocmd("TextChanged", {
      group = augroup,
      callback = function()
        local linters = fast_linters[vim.bo.filetype]
        if linters then
          lintmod.try_lint(linters)
        end

        if fast_linters_wildcard then
          lintmod.try_lint(fast_linters_wildcard)
        end
      end,
    })
    vim.api.nvim_create_autocmd({ "BufWritePost", "FileType" }, {
      group = augroup,
      callback = function()
        lintmod.try_lint()

        if linters_wildcard then
          lintmod.try_lint(linters_wildcard)
        end
      end,
    })

    lintmod.try_lint()
  end,
}
