-- statusline
-- https://github.com/nvim-lualine/lualine.nvim

vim.pack.add({
  "https://github.com/nvim-lualine/lualine.nvim",
})

local mod = require("lualine")

mod.setup({
  theme = "cendre",
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
    lualine_a = { "mode" },
    lualine_b = {
      {
        "diagnostics",
        always_visible = true,
      },
      {
        function ()
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
        cond = function ()
          return package.loaded["gitsigns"] ~= nil
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
        function ()
          local reg = vim.fn.reg_recording()
          if reg == "" then
            return ""
          end

          return "recording @" .. reg
        end,
      },
    },
    lualine_y = { "searchcount" },
    lualine_z = { "location" },
  },
})

local group = vim.api.nvim_create_augroup("9_LuaLine", {})
vim.api.nvim_create_autocmd("User", {
  group = group,
  pattern = "GitSignsUpdate",
  callback = function ()
    mod.refresh()
  end,
})
