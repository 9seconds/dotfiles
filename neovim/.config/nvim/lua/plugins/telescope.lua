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
    "nvim-telescope/telescope-live-grep-args.nvim",
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
    local lga_actions = require("telescope-live-grep-args.actions")

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
        live_grep_args = {
          auto_quoting = true,
          mappings = {
            i = {
              ["<C-t>"] = lga_actions.quote_prompt({
                postfix = " -t ",
              }),
              ["<C-k>"] = lga_actions.quote_prompt(),
              ["<C-g>"] = lga_actions.quote_prompt({
                postfix = " -g ",
              }),
            },
          },
        },
        fzy_native = {
          override_generic_sorter = true,
          override_file_sorter = true,
        },
      },
    })

    telescope.load_extension("fzy_native")
  end,
}

local frecency_config = {
  "nvim-telescope/telescope-frecency.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  keys = {
    {
      "<leader>tf",
      "<cmd>Telescope frecency workspace=CWD<cr>",
      desc = "List frecent files",
    },
  },

  config = function()
    require("telescope").load_extension("frecency")
  end,
}

local live_grep_args_config = {
  "nvim-telescope/telescope-live-grep-args.nvim",
  version = "*",
  keys = {
    {
      "<leader>tg",
      function()
        require("telescope").extensions.live_grep_args.live_grep_args()
      end,
      desc = "Live grep",
    },
    {
      "<leader>tw",
      function()
        require("telescope-live-grep-args.shortcuts").grep_word_under_cursor()
      end,
      desc = "Grep word under cursor",
    },
  },

  config = function()
    require("telescope").load_extension("live_grep_args")
  end,
}

return {
  telescope_config,
  frecency_config,
  live_grep_args_config,
}
