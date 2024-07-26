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
    "lewis6991/gitsigns.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  event = "VeryLazy",

  config = function()
    require("lualine").setup({
      theme = "tokyonight",

      options = {
        section_separators = "",
        component_separators = "",
        always_divide_middle = false,
        globalstatus = true,
      },

      extensions = {
        "lazy",
        "oil",
        "quickfix",
        "trouble",
      },

      sections = {
        lualine_a = {
          function()
            return vim.b.copilot_active and "" or ""
          end,
          "mode",
        },
        lualine_b = {
          "diagnostics",
          {
            function()
              local head = vim.b.gitsigns_head or ""
              local status = vim.b.gitsigns_status or ""

              if head == "" then
                return ""
              end

              if status == "" then
                return head
              end

              return head .. " | " .. status
            end,
            icon = "",
          },
        },
        lualine_c = {
          {
            "filename",
            path = 2,
            shorting_target = 30,
          },
        },
        lualine_x = {},
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
    })

    local group = vim.api.nvim_create_augroup("9_Macros", {})

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
