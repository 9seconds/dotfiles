-- diffview/mergetool
-- https://github.com/sindrets/diffview.nvim


return {
  "sindrets/diffview.nvim",
  cmd = {
    "DiffviewFileHistory",
    "DiffviewOpen"
  },

  opts = {
    enhanced_diff_hl = true,
    view = {
      merge_tool = {
        layout = "diff4_mixed"
      }
    }
  }
}
