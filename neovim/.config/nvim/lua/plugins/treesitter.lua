-- treesitter configuration
-- https://github.com/nvim-treesitter/nvim-treesitter

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
      "markdown", -- required for code-companion and markview
      "markdown_inline", -- required for markview
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
    },

    -- :h nvim-treesitter-indentation-mod
    indent = {
      enable = true,
    },

    -- nvim-treesitter-textobjects
    -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    textobjects = {
      swap = {
        enable = true,
        swap_next = {
          ["<leader><Right>"] = "@parameter.inner",
        },
        swap_previous = {
          ["<leader><Left>"] = "@parameter.inner",
        },
      },

      select = {
        enable = true,

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

local textobjects_config = {
  "nvim-treesitter/nvim-treesitter-textobjects",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  event = { "VeryLazy" },

  config = false,
}

return {
  treesitter_config,
  commentstring_config,
  textobjects_config,
}
