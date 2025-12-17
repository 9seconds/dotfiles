-- statusline
-- https://github.com/nvim-lualine/lualine.nvim

local STATE = {
  codecompanion_requests = 0,
}

return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "SmiteshP/nvim-navic",
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
    },

    sections = {
      lualine_a = {
        {
          function()
            if
              not vim.g.enable_autocompletion
              or vim.g.copilot_status == "InProgress"
            then
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
            local summary = vim.b.gitsigns_status_dict
            local output = { " " .. summary.head }

            if summary.added > 0 then
              table.insert(output, " " .. tostring(summary.added))
            end
            if summary.changed > 0 then
              table.insert(output, " " .. tostring(summary.changed))
            end
            if summary.removed > 0 then
              table.insert(output, " " .. tostring(summary.removed))
            end

            return vim.iter(output):join(" ")
          end,
          cond = function()
            return vim.b.gitsigns_status_dict ~= nil
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
