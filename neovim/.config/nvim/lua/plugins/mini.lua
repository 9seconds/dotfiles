-- different mini.nvim plugins
-- https://github.com/echasnovski/mini.nvim

-- Go forward/backward with square brackets
-- https://github.com/echasnovski/mini.bracketed
local mini_bracketed = {
  "echasnovski/mini.bracketed",
  version = "*",
  event = { "VeryLazy" },

  opts = {
    comment = { suffix = "" },
    diagnostic = { suffix = "" },
  },
}

-- Extend and create a/i textobjects
-- https://github.com/echasnovski/mini.ai
local mini_ai = {
  "echasnovski/mini.ai",
  version = "*",
  event = { "InsertEnter" },

  opts = {},
}

-- Split and join arguments
-- https://github.com/echasnovski/mini.splitjoin
local mini_splitjoin = {
  "echasnovski/mini.splitjoin",
  version = "*",
  keys = {
    "<leader>j",
  },

  opts = {
    mappings = {
      toggle = "<leader>j",
    },
  },
}

-- indentation
-- https://github.com/echasnovski/mini.indentscope
local mini_indentscope = {
  "echasnovski/mini.indentscope",
  version = "*",
  event = { "VeryLazy" },

  opts = {
    symbol = "│",
  },

  config = function(_, opts)
    local mod = require("mini.indentscope")

    mod.setup(vim.tbl_deep_extend("force", opts, {
      draw = {
        animation = mod.gen_animation.none(),
      },
    }))
  end,
}

-- Automatic highlighting of word under cursor
-- https://github.com/echasnovski/mini.cursorword
local mini_cursorword = {
  "echasnovski/mini.cursorword",
  version = "*",
  event = { "VeryLazy" },

  opts = {},
}

return {
  mini_bracketed,
  mini_ai,
  mini_splitjoin,
  mini_cursorword,
  mini_indentscope,
}
