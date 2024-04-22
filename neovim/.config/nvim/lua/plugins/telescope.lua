-- telescope stuff

local find_files_command = {
  "find",
  "-L",
  ".",
  "-type",
  "f,l",
}
local find_directories_command = {
  "find",
  "-L",
  ".",
  "-type",
  "d",
}
local vimgrep_arguments = nil

if vim.fn.executable("rg") then
  find_files_command = { "rg", "--files", "--color", "never" }
  vimgrep_arguments = { "rg", "--color", "never", "--vimgrep", "--trim" }
end

if vim.fn.executable("fd") then
  find_files_command = {
    "fd",
    "--strip-cwd-prefix",
    "--color",
    "never",
    "--type",
    "file",
    "--type",
    "symlink",
  }
  find_directories_command = {
    "fd",
    "--strip-cwd-prefix",
    "--color",
    "never",
    "--type",
    "directory",
  }
end

-- https://github.com/nvim-telescope/telescope.nvim
local telescope_config = {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "ahmedkhalf/project.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
    "nvim-telescope/telescope-fzy-native.nvim",
  },
  version = "*",
  keys = {
    {
      "<leader>tt",
      function()
        require("telescope.builtin").find_files({
          previewer = false,
          find_command = find_files_command,
        })
      end,
      desc = "Find files",
    },
    {
      "<leader>td",
      function()
        require("telescope.builtin").find_files({
          previewer = false,
          find_command = find_directories_command,
          prompt_title = "Find directories",
        })
      end,
      desc = "Find directories",
    },
    {
      "<leader>tb",
      function()
        require("telescope.builtin").buffers()
      end,
      desc = "Find buffers",
    },
    {
      "<leader>tl",
      function()
        require("telescope.builtin").current_buffer_fuzzy_find()
      end,
      desc = "Find a line within a buffer",
    },
    {
      "<leader>ts",
      function()
        require("telescope.builtin").git_status({})
      end,
      desc = "Git status",
    },
  },
  cmd = { "Telescope" },

  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        vimgrep_arguments = vimgrep_arguments,
        dynamic_preview_title = true,
        mappings = {
          i = {
            ["<esc>"] = actions.close,
          },
        },
      },

      extensions = {
        fzy_native = {
          override_generic_sorter = true,
          override_file_sorter = true,
        },
        egrepify = {
          prefixes = {
            ["^"] = {
              flag = "fixed-strings",
            },
            ["!"] = {
              flag = "invert-match",
            }
          }
        }
      },
    })

    telescope.load_extension("fzy_native")
  end,
}

-- wrappers for ripgrep
-- https://github.com/fdschmidt93/telescope-egrepify.nvim
local egrepify_config = {}
if vim.fn.executable("rg") then
  egrepify_config = {
    "fdschmidt93/telescope-egrepify.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    keys = {
      {
        "<leader>tg",
        function()
          return require("telescope").extensions.egrepify.egrepify({})
        end,
        desc = "Live grep with egrepify"
      }
    },

    config = function()
      require("telescope").load_extension("egrepify")
    end
  }
end

return {
  telescope_config,
  egrepify_config
}
