-- show function context
-- https://github.com/nvim-treesitter/nvim-treesitter-context

require("_.pack").add({
  url = "https://github.com/nvim-treesitter/nvim-treesitter-context",
  config = function()
    require("treesitter-context").setup({
      enable = true,
      max_lines = 10,
      separator = "-",
    })
  end,
})
