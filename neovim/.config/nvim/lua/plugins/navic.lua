-- breadcrumbs
-- https://github.com/SmiteshP/nvim-navic

return {
  "SmiteshP/nvim-navic",
  event = "VeryLazy",

  opts = {
    lsp = {
      auto_attach = true,
    },
    safe_output = true,
    highlight = true,
    depth_limit = 5,
  },
}
