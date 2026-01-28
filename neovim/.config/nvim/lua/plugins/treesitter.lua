-- treesitter configuration
-- https://github.com/nvim-treesitter/nvim-treesitter

local skip_treesitter = {
  "ergoterm",
  "fzf",
  "lazy",
  "lazy_backdrop",
  "snacks_notif",
}

local treesitter_config = {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",

  config = function()
    local mod = require("nvim-treesitter")

    mod.setup({})
    mod.install({
      "bash",
      "css",
      "diff",
      "editorconfig",
      "fish",
      "git_config",
      "git_rebase",
      "gitattributes",
      "gitcommit",
      "gitignore",
      "go",
      "gomod",
      "gosum",
      "html",
      "ini",
      "javascript",
      "json",
      "just",
      "regex",
      "kdl",
      "lua",
      "make",
      "markdown", -- required for code-companion and markview
      "markdown_inline", -- required for markview
      "python",
      "requirements",
      "ssh_config",
      "toml",
      "xml",
      "yaml",
    })

    local augroup = vim.api.nvim_create_augroup("9_TreeSitter", {})
    vim.api.nvim_create_autocmd({ "FileType" }, {
      group = augroup,
      callback = function(args)
        if vim.list_contains(skip_treesitter, args.match) then
          return
        end

        local parser_name = vim.treesitter.language.get_lang(args.match)
        if not parser_name then
          return
        end

        local parser_installed =
          pcall(vim.treesitter.get_parser, args.buf, parser_name)
        if not parser_installed then
          mod.install({ parser_name }):wait(30000)
        end

        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

        pcall(vim.treesitter.start)
      end,
    })
  end,
}

local commentstring_config = {
  "folke/ts-comments.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  event = { "VeryLazy" },

  opts = {},
}

return {
  treesitter_config,
  commentstring_config,
}
