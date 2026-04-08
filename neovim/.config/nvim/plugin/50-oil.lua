-- file buffer manager
-- https://github.com/stevearc/oil.nvim

vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1

require("_.pack").add(
  "https://github.com/stevearc/oil.nvim",
  vim.version.range("*"),
  function()
    require("oil").setup({
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

    vim.keymap.set(
      "n",
      "-",
      function()
        require("oil").open()
      end,
      {
        desc = "Oil: Open a directory"
      }
    )
  end,
  true
)
