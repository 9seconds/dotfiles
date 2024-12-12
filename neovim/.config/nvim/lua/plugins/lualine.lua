-- statusline
-- https://github.com/nvim-lualine/lualine.nvim

local function refresh()
  require("lualine").refresh({
    place = { "statusline" },
  })
end

return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "SmiteshP/nvim-navic",
    "lewis6991/gitsigns.nvim",
    "echasnovski/mini.icons",
  },
  event = "VeryLazy",

  opts = {
    theme = "tokyonight",

    options = {
      section_separators = "",
      component_separators = "",
      globalstatus = true,
    },

    extensions = {
      "lazy",
      "oil",
      "mason",
      "quickfix",
      "trouble",
    },

    sections = {
      lualine_a = {
        function()
          if vim.b.copilot_suggestion_auto_trigger then
            return ""
          end
          return ""
        end,
        "mode",
      },
      lualine_b = {
        {
          "diagnostics",
          always_visible = true,
        },
        "branch",
      },
      lualine_c = {
        {
          "filename",
          path = 1,
          shorting_target = 20,
        },
      },
      lualine_x = {
        {
          "navic",
          color_correction = "dynamic",
        },
      },
      lualine_y = {
        {
          function()
            local reg = vim.fn.reg_recording()
            if reg == "" then
              return ""
            end

            return "recording @" .. reg
          end,
        },
      },
      lualine_z = { "location" },
    },
  },

  config = function(_, opts)
    require("lualine").setup(opts)

    local group = vim.api.nvim_create_augroup("9_Lualine", {})

    vim.api.nvim_create_autocmd("RecordingEnter", {
      group = group,
      callback = refresh,
    })

    vim.api.nvim_create_autocmd("RecordingLeave", {
      group = group,
      callback = function()
        local timer = vim.uv.new_timer()
        timer:start(
          20,
          0,
          vim.schedule_wrap(function()
            timer:stop()
            timer:close()
            refresh()
          end)
        )
      end,
    })
  end,
}
