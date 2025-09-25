-- statusline
-- https://github.com/nvim-lualine/lualine.nvim

local STATE = {
  codecompanion_requests = 0,
}

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
        {
          function()
            if require("copilot.status").data.status == "InProgress" then
              return ""
            end
            return ""
          end,
          cond = function()
            return package.loaded["copilot"] ~= nil
          end,
        },
        {
          function()
            if STATE.codecompanion_requests > 0 then
              return "󰭻"
            end
            return ""
          end,
        },
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
            local output = { " " .. git_summary.head_name }

            if git_summary.in_progress ~= "" then
              table.insert(output, "(" .. git_summary.in_progress .. ")")
            end

            local diff_summary = vim.b.minidiff_summary
              or {
                n_ranges = 0,
              }

            if diff_summary.n_ranges > 0 then
              table.insert(output, " " .. tostring(diff_summary.n_ranges))

              if diff_summary.add > 0 then
                table.insert(output, " " .. tostring(diff_summary.add))
              end
              if diff_summary.change > 0 then
                table.insert(output, " " .. tostring(diff_summary.change))
              end
              if diff_summary.delete > 0 then
                table.insert(output, " " .. tostring(diff_summary.delete))
              end
            end

            return vim.iter(output):join(" ")
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
    local mod = require("lualine")

    mod.setup(opts)

    local group = vim.api.nvim_create_augroup("9_Lualine", {})
    vim.api.nvim_create_autocmd("User", {
      group = group,
      pattern = "CodeCompanionRequestStarted",
      callback = function()
        STATE.codecompanion_requests = STATE.codecompanion_requests + 1
        mod.refresh()
      end,
    })
    vim.api.nvim_create_autocmd("User", {
      group = group,
      pattern = "CodeCompanionRequestFinished",
      callback = function()
        STATE.codecompanion_requests = STATE.codecompanion_requests - 1
        mod.refresh()
      end,
    })
    vim.api.nvim_create_autocmd("User", {
      group = group,
      pattern = "CodeCompanionChatCleared",
      callback = function()
        STATE.codecompanion_requests = 0
        mod.refresh()
      end,
    })
  end,
}
