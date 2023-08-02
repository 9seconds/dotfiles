-- jump across treesitter nodes
-- https://github.com/drybalka/tree-climber.nvim


local opts = {
  skip_comments = true,
}

local function and_select(callback)
  return function()
    callback()
    return require("tree-climber").select_node(opts)
  end
end

local function parent()
  return require("tree-climber").goto_parent(opts)
end

local function child()
  return require("tree-climber").goto_child(opts)
end

local function next()
  return require("tree-climber").goto_next(opts)
end

local function prev()
  return require("tree-climber").goto_prev(opts)
end


return {
  "drybalka/tree-climber.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter"
  },
  keys = {
    {
      "<up>", parent,
      mode = {"n", "v"},
      desc = "Jump to the treesitter parent"
    },
    {
      "<leader><up>", and_select(parent),
      mode = {"n", "v"},
      desc = "Select treesitter parent node"
    },
    {
      "<down>", child,
      mode = {"n", "v"},
      desc = "Jump to the treesitter child"
    },
    {
      "<leader><down>", and_select(child),
      mode = {"n", "v"},
      desc = "Select treesitter child node"
    },
    {
      "<left>", prev,
      mode = {"n", "v"},
      desc = "Jump to the previous treesitter node"
    },
    {
      "<leader><left>", and_select(prev),
      mode = {"n", "v"},
      desc = "Select treesitter previous node"
    },
    {
      "<right>", next,
      mode = {"n", "v"},
      desc = "Jump to the next treesitter node"
    },
    {
      "<leader><right>", and_select(next),
      mode = {"n", "v"},
      desc = "Select treesitter next node"
    },
  },
}
