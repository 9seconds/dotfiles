-- conflict resolver
-- https://github.com/spacedentist/resolve.nvim/

return {
  "spacedentist/resolve.nvim",
  event = {
    "BufReadPre",
    "BufNewFile",
  },

  opts = {},
}
