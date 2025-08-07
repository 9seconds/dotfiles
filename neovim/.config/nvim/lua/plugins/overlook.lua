-- peek implementations
-- https://github.com/WilliamHsieh/overlook.nvim

return {
  "WilliamHsieh/overlook.nvim",
  keys = {
    {
      "<leader>pd",
      function()
        return require("overlook.api").peek_definition()
      end,
      desc = "Peek definition",
    },
    {
      "<leader>ps",
      function()
        return require("overlook.api").switch_focus()
      end,
      desc = "Switch focus between definition and main window",
    },
    {
      "<leader>pv",
      function()
        return require("overlook.api").open_in_vsplit()
      end,
      desc = "Open popup in vertical split",
    },
    {
      "<leader>px",
      function()
        return require("overlook.api").open_in_split()
      end,
      desc = "Open popup in horizontal split",
    },
    {
      "<leader>pt",
      function()
        return require("overlook.api").open_in_tab()
      end,
      desc = "Open popup in tab",
    },
    {
      "<leader>pw",
      function()
        return require("overlook.api").open_in_original_window()
      end,
      desc = "Open popup in original window",
    },
    {
      "<leader>pc",
      function()
        return require("overlook.api").close_all()
      end,
      desc = "Close all popups",
    },
    {
      "<leader>pu",
      function()
        return require("overlook.api").restore_popup()
      end,
      desc = "Restore popup",
    },
    {
      "<leader>pU",
      function()
        return require("overlook.api").restore_all_popups()
      end,
      desc = "Restore all popups",
    },
    {
      "<leader>pp",
      function()
        return require("overlook.api").peek_cursor()
      end,
      desc = "Peek at current cursor",
    },
  },

  opts = {},
}
