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

-- icons
-- https://github.com/echasnovski/mini.icons
local mini_icons = {
  "echasnovski/mini.icons",
  version = "*",
  event = {
    "UIEnter",
  },

  opts = {},

  config = function(_, opts)
    local mod = require("mini.icons")

    mod.setup(opts)
    mod.mock_nvim_web_devicons()

    vim.api.nvim_create_autocmd("User", {
      group = vim.api.nvim_create_augroup("9_Icons", {}),
      pattern = "VeryLazy",
      once = true,
      callback = function()
        mod.tweak_lsp_kind()
      end,
    })
  end,
}

-- auto pairs
-- https://github.com/echasnovski/mini.pairs
local mini_pairs = {
  "echasnovski/mini.pairs",
  version = "*",
  event = {
    "InsertEnter",
    "CmdlineEnter"
  },

  opts = {
    modes = {
      insert = true,
      command = true,
    }
  }
}


return {
  mini_bracketed,
  mini_ai,
  mini_splitjoin,
  mini_cursorword,
  mini_indentscope,
  mini_icons,
  mini_pairs,
}
