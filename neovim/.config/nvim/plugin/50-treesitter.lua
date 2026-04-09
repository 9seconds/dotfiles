-- treesitter wrappers
-- https://github.com/neovim-treesitter/nvim-treesitter

local skip_treesitter = {
  "blink-cmp-documentation",
  "blink-cmp-menu",
  "blink-cmp-menu",
  "blink-cmp-signature",
  "ergoterm",
  "flash_prompt",
  "fzf",
  "lazy",
  "lazy_backdrop",
  "oil",
  "qf",
  "snacks_notif",
  "snacks_terminal",
  "snacks_win_backdrop",
}

local ensure_installed = {
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
}

require("_.pack").add({
  url = "https://github.com/neovim-treesitter/nvim-treesitter",
  releases = "main",
  config = function()
    local mod = require("nvim-treesitter")

    mod.install(ensure_installed)

    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("9_PackTreesitter", {}),
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
})
