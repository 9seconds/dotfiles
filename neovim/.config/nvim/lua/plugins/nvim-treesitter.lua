-- treesitter configuration
-- https://github.com/nvim-treesitter/nvim-treesitter


local max_file_size = 100 * 1024  -- 100 kilobytes


local function disable_on_max_filesize(_, bufnr)
  return require("_.utils").get_buf_file_size(bufnr) >= max_file_size
end


return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "nvim-treesitter/nvim-treesitter-refactor",
    "JoosepAlviste/nvim-ts-context-commentstring",
    "andymass/vim-matchup"
  },
  event = "VeryLazy",
  main = "nvim-treesitter.configs",

  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = "all",
      sync_install = true,

      -- :h nvim-treesitter-highlight-mod
      highlight = {
        enable = true,
        disable = disable_on_max_filesize,
      },

      -- :h nvim-treesitter-indentation-mod
      indent = {
        enable = true,
        disable = disable_on_max_filesize,
      },

      -- https://github.com/andymass/vim-matchup
      matchup = {
        enable = true,
        disable = disable_on_max_filesize,
      },

      -- nvim-treesitter-textobjects
      -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
      textobjects = {
        swap = {
          enable = true,
          disable = disable_on_max_filesize,

          swap_next = {
            ["<leader>a"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader>A"] = "@parameter.inner",
          },
        },

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
          }
        }
      },

      -- nvim-treesitter-refactor
      -- https://github.com/nvim-treesitter/nvim-treesitter-refactor
      refactor = {
        highlight_definitions = {
          enable = true,
          disable = disable_on_max_filesize,

          clear_on_cursor_move = true,
        },
      },

      -- set commentstring based on a position in a file
      -- https://github.com/JoosepAlviste/nvim-ts-context-commentstring
      context_commentstring = {
        enable = true,
      }
    })
  end
}
