-- telescope stuff

local find_files_command = {
  "find",
  "-L",
  ".",
  "-type",
  "f,l",
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
    "--hidden",
    "--exclude",
    ".git",
  }
end

-- https://github.com/nvim-telescope/telescope.nvim
local telescope_config = {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "echasnovski/mini.icons",
    "nvim-telescope/telescope-fzy-native.nvim",
  },
  version = "*",
  keys = {
    {
      "<leader>tt",
      function()
        return require("telescope.builtin").find_files({
          find_command = find_files_command,
          previewer = false,
          layout_strategy = "vertical",
          layout_config = {
            vertical = {
              height = 0.6,
            },
          },
        })
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
      "<leader>tw",
      function()
        require("telescope.builtin").grep_string()
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
    {
      "grr",
      function()
        return require("telescope.builtin").lsp_references()
      end,
      desc = "LSP: Show references",
    },
    {
      "gO",
      function()
        return require("telescope.builtin").lsp_document_symbols()
      end,
      desc = "LSP: Document symbols in current document",
    },
    {
      "gW",
      function()
        return require("telescope.builtin").lsp_workspace_symbols()
      end,
      desc = "LSP: Document symbols in current workspace",
    },
    {
      "grh",
      function()
        return vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
      end,
      desc = "LSP: Toggle inlay hints",
    },
    {
      "grh",
      function()
        return require("telescope.builtin").lsp_implementations()
      end,
      desc = "LSP: Show implementations",
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
          override_generic_sorter = false,
          override_file_sorter = true,
        },
        egrepify = {
          prefixes = vim.tbl_extend("force", {
            ["^"] = {
              flag = "fixed-strings",
            },
            ["@"] = {
              flag = "type",
            },
          }, vim.g.telescope_egrepify_prefixes or {}),
        },
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
        desc = "Live grep with egrepify",
      },
    },

    config = function()
      require("telescope").load_extension("egrepify")
    end,
  }
end

return {
  telescope_config,
  egrepify_config,
}
