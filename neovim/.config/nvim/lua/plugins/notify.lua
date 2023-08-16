-- fancy notifications
-- https://github.com/rcarriga/nvim-notify


return {
  "rcarriga/nvim-notify",
  version = "*",
  event = "VeryLazy",

  init = function()
    vim.o.termguicolors = true
  end,

  config = function()
    local notify = require("notify")

    notify.setup({
      render = "compact",
      stages = "fade"
    })

    vim.notify = notify
  end
}
