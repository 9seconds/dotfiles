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
  event = { "BufReadPre", "BufNewFile" },

  main = "nvim-treesitter.configs",
  opts = {
    ensure_installed = "all",
    sync_install = true,

    -- :h nvim-treesitter-highlight-mod
    highlight = {
      enable = true,
      disable = disable_on_max_filesize,
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
  "JoosepAlviste/nvim-ts-context-commentstring",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  event = { "FileType" },

  opts = {},
}

local textobjects_config = {
  "nvim-treesitter/nvim-treesitter-textobjects",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  event = { "FileType" },
}

return {
  treesitter_config,
  commentstring_config,
  textobjects_config,
}
