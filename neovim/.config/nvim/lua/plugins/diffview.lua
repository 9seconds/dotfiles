-- diffview
-- https://github.com/sindrets/diffview.nvim

return {
  "sindrets/diffview.nvim",
  dependencies = {
    "echasnovski/mini.icons",
  },
  cmd = {
    "DiffviewOpen",
    "DiffviewFileHistory",
    "DiffviewClose",
    "DiffviewToggleFiles",
    "DiffviewFocusFiles",
    "DiffviewRefresh",
    "DiffviewLog",
  },

  opts = {
    enhanced_diff_hl = true,
    view = {
      merge_tool = {
        layout = "diff4_mixed",
      },
    },
  },
}
