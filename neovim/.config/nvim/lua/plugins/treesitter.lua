-- treesitter configuration
-- https://github.com/nvim-treesitter/nvim-treesitter

local max_file_size_kb = 200 * 1024

local function disable_on_max_filesize(_, bufnr)
  return require("_.utils").get_buf_file_size(bufnr) >= 1024 * max_file_size_kb
end

local treesitter_config = {
  "nvim-treesitter/nvim-treesitter",
  build = function()
    require("nvim-treesitter.install").update({ with_sync = true })()
  end,

  main = "nvim-treesitter.configs",
  opts = {
    ensure_installed = {
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
      "kdl",
      "lua",
      "make",
      "python",
      "requirements",
      "ssh_config",
      "toml",
      "xml",
      "yaml",
    },
    sync_install = true,
    auto_install = true,

    -- :h nvim-treesitter-highlight-mod
    highlight = {
      enable = true,
    },

    -- see matchup.lua
    -- https://github.com/andymass/vim-matchup
    matchup = {
      enable = true,
      disable = disable_on_max_filesize,
    },

    -- :h nvim-treesitter-indentation-mod
    indent = {
      enable = true,
      disable = disable_on_max_filesize,
    },

    -- nvim-treesitter-textobjects
    -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    textobjects = {
      select = {
        enable = true,
        disable = disable_on_max_filesize,

        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
          ["ia"] = "@parameter.inner",
          ["aa"] = "@parameter.outer",
          ["ab"] = "@block.outer",
          ["ib"] = "@block.inner",
        },
      },
    },
  },
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
