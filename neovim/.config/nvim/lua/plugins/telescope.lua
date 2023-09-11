-- telescope stuff

local fzf_build = "make"

if vim.fn.executable("cmake") then
  fzf_build =
    "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
end

-- https://github.com/nvim-telescope/telescope.nvim
local telescope_config = {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "ahmedkhalf/project.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = fzf_build,
    },
  },
  version = "*",
  keys = {
    {
      "<leader>tf",
      function()
        require("telescope.builtin").find_files({ previewer = false })
      end,
      desc = "Find files",
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
      "<leader>tt",
      function()
        require("telescope.builtin").tags()
      end,
      desc = "Find in tags",
    },
    {
      "<leader>tg",
      function()
        require("telescope.builtin").live_grep()
      end,
      desc = "Live grep",
    },
  },
  cmd = { "Telescope" },

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
        "never",
        "--type",
        "file",
        "--type",
        "symlink",
        "--",
      }
    end

    telescope.setup({
      defaults = {
        vimgrep_arguments = vimgrep_arguments,
        dynamic_preview_title = true,
      },
      pickers = {
        find_files = {
          find_command = find_command,
        },
        buffers = {
          mappings = {
            i = {
              ["<C-k>"] = actions.delete_buffer,
            },
          },
        },
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
              end,
            },
          },
        },
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    })

    telescope.load_extension("fzf")
  end,
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
      desc = "Find recent file",
    },
  },

  config = function()
    require("telescope").load_extension("recent_files")
  end,
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
      desc = "Find undo position",
    },
  },

  config = function()
    require("telescope").load_extension("undo")
  end,
}

return {
  telescope_config,
  recent_files_config,
  undo_config,
}
