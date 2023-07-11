-- telescope stuff

-- https://github.com/nvim-telescope/telescope.nvim
local telescope_config = {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
    "natecraddock/telescope-zf-native.nvim",
  },
  version = "*",
  keys = {
    {
      "<leader>tt",
      function()
        require("telescope.builtin").find_files({previewer = false})
      end,
    },
    {
      "<leader>td",
      function()
        require("telescope.builtin").find_files({
          previewer = false,
          search_dirs = { "~/.dotfiles" },
        })
      end,
    },
    {
      "<leader>tb",
      function()
        require("telescope.builtin").buffers()
      end,
    },
    {
      "<leader>tc",
      function()
        require("telescope.builtin").current_buffer_fuzzy_find()
      end,
    },
    {
      "<leader>tg",
      function()
        require("telescope.builtin").tags()
      end,
    },
    {
      "<leader>tf",
      function()
        require("telescope.builtin").live_grep()
      end,
    },
  },

  config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      local find_command = { "find", ".", "-type", "f" }
      local vimgrep_arguments = nil

      if vim.fn.executable("rg") then
        find_command = { "rg", "--files", "--color", "never" }
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--trim",
        }
      end

      if vim.fn.executable("fd") then
        find_command = {
          "fd",
          "--strip-cwd-prefix",
          "--color",
          "never"
        }
      end

      telescope.setup({
        defaults = {
          vimgrep_arguments = vimgrep_arguments
        },
        pickers = {
          find_files = {
            find_command = find_command,
          },
          buffers = {
            mappings = {
              i = {
                ["<C-k>"] = actions.delete_buffer
              }
            }
          }
        },

        extensions = {
          recent_files = {
            only_cwd = true,
          },
          undo = {
            use_delta = false,
            mappings = {
              i = {
                ["<cr>"] = function(bufnr)
                  return require("telescope-undo.actions").restore(bufnr)
                end
              },
            },
          },
          ["zf-native"] = {
            file = {
              -- override default telescope file sorter
              enable = true,
              -- highlight matching text in results
              highlight_results = true,
              -- enable zf filename match priority
              match_filename = true,
            },
            -- options for sorting all other items
            generic = {
              -- override default telescope generic item sorter
              enable = true,
              -- highlight matching text in results
              highlight_results = true,
              -- disable zf filename match priority
              match_filename = false,
            },
          },
        },
      })

      telescope.load_extension("zf-native")
  end
}

-- https://github.com/smartpde/telescope-recent-files
local recent_files_config = {
  "smartpde/telescope-recent-files",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  keys = {
    {
      "<leader>tr",
      function()
        require("telescope").extensions.recent_files.pick()
      end,
    }
  },

  config = function()
    require("telescope").load_extension("recent_files")
  end
}

-- https://github.com/debugloop/telescope-undo.nvim
local undo_config = {
  "debugloop/telescope-undo.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  keys = {
    {
      "<leader>tu",
      function()
        require("telescope").extensions.undo.undo()
      end,
    }
  },

  config = function()
    require("telescope").load_extension("undo")
  end
}

return {
  telescope_config,
  recent_files_config,
  undo_config,
}
