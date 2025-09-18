-- statusline
-- https://github.com/nvim-lualine/lualine.nvim

return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "SmiteshP/nvim-navic",
    "nvim-mini/mini-git",
    "nvim-mini/mini.icons",
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
      "fzf",
      "lazy",
      "oil",
      "quickfix",
      "toggleterm",
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
        function()
          if vim.g.code_companion_in_progress then
            return "󱜸"
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
        {
          function()
            local git_summary = vim.b.minigit_summary
            local output = " " .. git_summary.head_name

            if git_summary.status then
              output = output .. " (" .. vim.trim(git_summary.status) .. ")"
            end

            if git_summary.in_progress ~= "" then
              output = output .. " " .. git_summary.in_progress
            end

            local diff_summary = vim.b.minidiff_summary
            if diff_summary == nil then
              return output
            end

            local summary_chunks = {}
            if diff_summary.add > 0 then
              table.insert(summary_chunks, "+" .. tostring(diff_summary.add))
            end
            if diff_summary.change > 0 then
              table.insert(summary_chunks, "~" .. tostring(diff_summary.change))
            end
            if diff_summary.delete > 0 then
              table.insert(summary_chunks, "-" .. tostring(diff_summary.delete))
            end

            if #summary_chunks > 0 then
              output = output .. " " .. vim.iter(summary_chunks):join("/")
            end

            return output
          end,
          cond = function()
            return vim.b.minigit_summary ~= nil
          end,
        },
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
      lualine_z = {},
    },
  },

  config = function(_, opts)
    require("lualine").setup(opts)

    local group = vim.api.nvim_create_augroup("9_Lualine", {})

    vim.api.nvim_create_autocmd("RecordingEnter", {
      group = group,
      callback = function()
        require("_.utils").refresh_statusline()
      end,
    })

    vim.api.nvim_create_autocmd("RecordingLeave", {
      group = group,
      callback = function()
        local timer = vim.uv.new_timer()
        local utils = require("_.utils")

        timer:start(
          20,
          0,
          vim.schedule_wrap(function()
            timer:stop()
            timer:close()
            utils.refresh_statusline()
          end)
        )
      end,
    })
  end,
}
