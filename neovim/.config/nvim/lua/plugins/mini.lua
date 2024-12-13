-- different mini.nvim plugins
-- https://github.com/echasnovski/mini.nvim

-- Go forward/backward with square brackets
-- https://github.com/echasnovski/mini.bracketed
local mini_bracketed = {
  "echasnovski/mini.bracketed",
  version = "*",
  event = "VeryLazy",

  opts = {
    comment = { suffix = "" },
    diagnostic = { suffix = "" },
  },
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
  event = "VeryLazy",

  opts = {
    symbol = "│",
    mappings = {
      object_scope = "",
      object_scope_with_border = "",
      goto_top = "",
      goto_bottom = ""
    }
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
  event = "VeryLazy",

  opts = {},
}

-- icons
-- https://github.com/echasnovski/mini.icons
local mini_icons = {
  "echasnovski/mini.icons",
  version = "*",
  event = "VeryLazy",

  opts = {},

  config = function(_, opts)
    local mod = require("mini.icons")

    mod.setup(opts)
    mod.mock_nvim_web_devicons()
  end,
}

-- auto pairs
-- https://github.com/echasnovski/mini.pairs
local mini_pairs = {
  "echasnovski/mini.pairs",
  version = "*",
  event = {
    "InsertEnter",
    "CmdlineEnter",
  },

  opts = {
    modes = {
      insert = true,
      command = true,
    },
  },
}

return {
  mini_bracketed,
  mini_splitjoin,
  mini_cursorword,
  mini_indentscope,
  mini_icons,
  mini_pairs,
}
