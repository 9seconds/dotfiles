-- statusline
-- https://github.com/nvim-lualine/lualine.nvim


return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "lewis6991/gitsigns.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  event = "VeryLazy",

  opts = {
    options = {
      section_separators = "",
      component_separators = "",
      always_divide_middle = false,
      globalstatus = true,
    },
    extensions = {
      "lazy",
      "neo-tree",
      "quickfix",
      "trouble"
    },
    theme = "tokyonight",
    sections = {
      lualine_a = {"mode"},
      lualine_b = {{
        "b:gitsigns_head",
        icon = "",
        fmt = function(line)
          if vim.fn.winnr("$") > 1 then
            return ""
          end

          return line
        end,
      }},
      lualine_c = {{
        "filename",
        path=2,
        shorting_target=30,
      }},
      lualine_x = {"diagnostics"},
      lualine_y = {"location"},
      lualine_z = {{
        "datetime",
        style = "%H:%M"
      }},
    }
  }
}
