-- fancy notifications
-- https://github.com/rcarriga/nvim-notify

return {
  "rcarriga/nvim-notify",
  version = "*",
  event = "VeryLazy",

  init = function()
    vim.o.termguicolors = true
  end,

  opts = {
    render = "compact",
    stages = "fade",
  },

  config = function(_, opts)
    local notify = require("notify")

    notify.setup(opts)

    vim.notify = notify
  end,
}
