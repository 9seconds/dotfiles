-- different mini.nvim plugins
-- https://github.com/echasnovski/mini.nvim

-- Go forward/backward with square brackets
-- https://github.com/echasnovski/mini.bracketed
local mini_bracketed = {
  "echasnovski/mini.bracketed",
  lazy = true,

  opts = {
    comment = "",
    diagnostic = "",
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

return {
  mini_bracketed,
  mini_ai,
  mini_splitjoin,
}
