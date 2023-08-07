-- configuration for a drawer
-- https://github.com/nvim-neo-tree/neo-tree.nvim


return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    {
      "s1n7ax/nvim-window-picker",
      version = "2.*",
      event = "VeryLazy",

      opts = {}
    }
  },
  cmd = "Neotree",
  keys = {
    {
      "<leader>ef",
      "<cmd>Neotree toggle<cr>",
      desc = "Open neotree"
    },
    {
      "<leader>ec",
      "<cmd>Neotree reveal<cr>",
      desc = "Reveal current file in neotree"
    },
  },

  opts = function()
    vim.g.neo_tree_remove_legacy_commands = 1

    return {
      sources = {
        "filesystem",
        "document_symbols"
      },

      source_selector = {
        winbar = true,
        sources = {
          { source = "filesystem", display_name = " 󰉓 Files " },
          { source = "document_symbols", display_name = "  Symbols"}
        },
      },

      default_component_configs = {
        icon = {
          folder_empty = "",
          folder_empty_open = "",
        },
        git_status = {
          symbols = {
            renamed   = "󰁕",
            unstaged  = "",
          },
        },
      },
      document_symbols = {
        kinds = {
          File = { icon = "󰈙", hl = "Tag" },
          Namespace = { icon = "󰌗", hl = "Include" },
          Package = { icon = "󰏖", hl = "Label" },
          Class = { icon = "󰌗", hl = "Include" },
          Property = { icon = "󰆧", hl = "@property" },
          Enum = { icon = "󰒻", hl = "@number" },
          Function = { icon = "󰊕", hl = "Function" },
          String = { icon = "󰀬", hl = "String" },
          Number = { icon = "󰎠", hl = "Number" },
          Array = { icon = "󰅪", hl = "Type" },
          Object = { icon = "󰅩", hl = "Type" },
          Key = { icon = "󰌋", hl = "" },
          Struct = { icon = "󰌗", hl = "Type" },
          Operator = { icon = "󰆕", hl = "Operator" },
          TypeParameter = { icon = "󰊄", hl = "Type" },
          StaticMethod = { icon = '󰠄 ', hl = 'Function' },
        }
      },

      filesystem = {
        use_libuv_file_watcher = true,
      },

      close_if_last_window = false,
      sort_case_insensitive = true,
    }
  end
}
