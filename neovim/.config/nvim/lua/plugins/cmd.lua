-- command runner
-- https://github.com/y3owk1n/cmd.nvim

return {
  "y3owk1n/cmd.nvim",
  dependencies = {
    "folke/snacks.nvim",
  },
  cmd = {
    "Cmd",
    "Git",
  },

  opts = function()
    return {
      progress_notifier = {
        adapter = require("cmd").builtins.spinner_adapters.snacks,
      },
      create_usercmd = {
        git = "Git",
      },
      force_terminal = {
        git = {
          "log",
          "rebase",
          "merge",
          "commit --amend"
        },
      },
    }
  end,
}
