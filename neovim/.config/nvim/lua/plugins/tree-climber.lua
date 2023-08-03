-- jump across treesitter nodes
-- https://github.com/drybalka/tree-climber.nvim


local opts = {
  skip_comments = true,
}

return {
  "drybalka/tree-climber.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter"
  },
  keys = {
    {
      "<up>",
      function()
        return require("tree-climber").goto_parent(opts)
      end,
      mode = {"n", "v"},
      desc = "Jump to the treesitter parent"
    },
    {
      "<leader><up>",
      function()
        local mod = require("tree-climber")

        mod.goto_parent(opts)

        return mod.select_node(opts)
      end,
      mode = {"n", "v"},
      desc = "Select treesitter parent node"
    },
    {
      "<down>",
      function()
        return require("tree-climber").goto_child(opts)
      end,
      mode = {"n", "v"},
      desc = "Jump to the treesitter child"
    },
    {
      "<leader><down>",
      function()
        local mod = require("tree-climber")

        mod.goto_child(opts)

        return mod.select_node(opts)
      end,
      mode = {"n", "v"},
      desc = "Select treesitter child node"
    },
    {
      "<left>",
      function()
        return require("tree-climber").goto_prev(opts)
      end,
      mode = {"n", "v"},
      desc = "Jump to the previous treesitter node"
    },
    {
      "<right>",
      function()
        return require("tree-climber").goto_next(opts)
      end,
      mode = {"n", "v"},
      desc = "Jump to the next treesitter node"
    },
  },
}
