-- different mini.nvim plugins
-- https://github.com/echasnovski/mini.nvim

-- Go forward/backward with square brackets
-- https://github.com/echasnovski/mini.bracketed
local mini_bracketed = {
  "echasnovski/mini.bracketed",
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
  event = { "InsertEnter" },

  opts = {},
}

-- Split and join arguments
-- https://github.com/echasnovski/mini.splitjoin
local mini_splitjoin = {
  "echasnovski/mini.splitjoin",
  keys = {
    "<leader>j",
  },

  opts = {
    mappings = {
      toggle = "<leader>j",
    },
  },
}

-- Automatic highlighting of word under cursor
-- https://github.com/echasnovski/mini.cursorword
local mini_cursorword = {
  "echasnovski/mini.cursorword",
  event = { "VeryLazy" },

  opts = {},
}

return {
  mini_bracketed,
  mini_ai,
  mini_splitjoin,
  mini_cursorword,
}
