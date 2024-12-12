-- toggling between files I care
-- https://github.com/cbochs/grapple.nvim

local CLEANUP_EACH = (
  1000 -- second
  * 60 -- minute
  * 60 -- hour
)

return {
  "cbochs/grapple.nvim",
  dependencies = {
    "echasnovski/mini.icons",
  },
  keys = {
    {
      "<leader>pa",
      function()
        local mod = require("grapple")

        if mod.exists() then
          vim.api.nvim_notify("Removed from grapple", vim.log.levels.INFO, {})
          mod.untag()
        else
          vim.api.nvim_notify("Added from grapple", vim.log.levels.INFO, {})
          mod.tag()
        end
      end,
      desc = "Toggle Grapple",
    },
    {
      "<leader>pt",
      function()
        return require("grapple").toggle_tags()
      end,
      desc = "Toggle grapple tags",
    },
    {
      "[p",
      function()
        return require("grapple").cycle_tags("prev", {})
      end,
      desc = "Go to previous grapple tag",
    },
    {
      "]p",
      function()
        return require("grapple").cycle_tags("next", {})
      end,
      desc = "Go to next grapple tag",
    },
  },
  cmd = "Grapple",

  opts = {
    icons = true,
    scope = "git_branch",
    style = "basename",
    prune = "7d",
  },

  config = function(_, opts)
    local mod = require("grapple")

    mod.setup(opts)

    local timer = vim.uv.new_timer()
    timer:start(0, CLEANUP_EACH, vim.schedule_wrap(mod.prune))
  end,
}
