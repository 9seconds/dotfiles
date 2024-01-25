-- file buffer manager
-- https://github.com/stevearc/oil.nvim

return {
  "stevearc/oil.nvim",
  event = "VimEnter",

  config = function()
    local oil = require("oil")

    oil.setup({
      columns = {
        "icon",
        "permissions",
        "size",
      },
      keymaps = {
        ["<C-h>"] = false,
        ["<C-l>"] = false,
        ["<C-x>"] = "actions.select_split",
      },
    })

    vim.keymap.set("n", "-", oil.open, { desc = "Open directory with Oil" })
  end,
}
