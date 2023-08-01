-- treesitter configuration
-- https://github.com/nvim-treesitter/nvim-treesitter


return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "nvim-treesitter/nvim-treesitter-refactor",
    "JoosepAlviste/nvim-ts-context-commentstring",
  },

  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = "all",
      sync_install = true,

      highlight = {
        enable = true
      },

      incremental_selection = {
        enable = true
      },

      indent = {
        enable = true
      },

      -- nvim-treesitter-textobjects
      -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
      textobjects = {
        swap = {
          enable = true,

          swap_next = {
            ["<leader>a"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader>A"] = "@parameter.inner",
          },
        },

        select = {
          enable = true,

          lookahead = true,
          keymaps = {
            ["af"]="@function.outer",
            ["if"]="@function.inner",
            ["ac"]="@class.outer",
            ["ic"]="@class.inner",
            ["ia"]="@parameter.inner",
            ["aa"]="@parameter.outer",
            ["ab"]="@block.outer",
            ["ib"]="@block.inner",
          }
        }
      },

      -- nvim-treesitter-refactor
      -- https://github.com/nvim-treesitter/nvim-treesitter-refactor
      refactor = {
        highlight_definitions = {
          enable = true,

          clear_on_cursor_move = true,
        },

        smart_rename = {
          enable = true,

          keymaps = {
            smart_rename = "grr",
          },
        }
      },

      -- set commentstring based on a position in a file
      -- https://github.com/JoosepAlviste/nvim-ts-context-commentstring
      context_commentstring = {
        enable = true,
      },
    })

    vim.o.foldmethod= "expr"
    vim.o.foldexpr = "nvim_treesitter#foldexpr()"
  end
}
