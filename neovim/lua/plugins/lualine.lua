-- statusline
-- https://github.com/nvim-lualine/lualine.nvim


return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "SmiteshP/nvim-navic"
  },
  event = "VeryLazy",

  config = function()
    local navic = require("nvim-navic")

    require("lualine").setup({
      options = {
        section_separators = "",
        component_separators = "",
        always_divide_middle = false,
        globalstatus = true,
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
        lualine_x = {
          {navic.get_location, cond=navic.is_available}
        },
        lualine_y = {},
        lualine_z = {"location"},
      }
    })
  end
}
