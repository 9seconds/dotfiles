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
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    {
      "<leader>ga",
      function()
        local mod = require("grapple")

        if mod.exists() then
          vim.api.nvim_notify(" Removed from grapple ", "info")
          mod.untag()
        else
          vim.api.nvim_notify(" Added from grapple ", "info")
          mod.tag()
        end
      end,
      desc = "Toggle Grapple",
    },
    {
      "[g",
      function()
        return require("grapple").cycle_tags("prev", {})
      end,
      desc = "Toggle Grapple menu",
    },
    {
      "]g",
      function()
        return require("grapple").cycle_tags("next", {})
      end,
      desc = "Toggle Grapple menu",
    },
  },

  config = function()
    local mod = require("grapple")

    mod.setup({
      icons = true,
      scope = "git_branch",
      style = "basename",
      prune = "7d",
    })

    local timer = vim.uv.new_timer()
    timer:start(0, CLEANUP_EACH, vim.schedule_wrap(mod.prune))
  end,
}
