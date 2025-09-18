-- different mini.nvim plugins
-- https://github.com/echasnovski/mini.nvim

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

-- snippet management
-- https://github.com/echasnovski/mini.snippets
local mini_snippets = {
  "echasnovski/mini.snippets",
  version = "*",
  keys = {
    {
      "<c-j>",
      mode = "i",
      desc = "Expand snippet",
    },
    {
      "<leader>c",
      function()
        local sess = require("mini.snippets").session

        while sess.get() do
          sess.stop()
        end
      end,
      desc = "Stop all snippet sessions",
    },
  },

  opts = function()
    local mod = require("mini.snippets")

    return {
      mappings = {
        stop = "<c-k>",
      },

      snippets = {
        mod.gen_loader.from_file(
          vim.fs.joinpath(vim.fn.stdpath("config"), "snippets", "_.lua")
        ),
        mod.gen_loader.from_lang(),

        mod.gen_loader.from_file(vim.fs.joinpath(".snippets", "_.lua")),
        function(ctx)
          local filename = vim.fs.joinpath(".snippets", ctx.lang .. ".lua")
          if vim.uv.fs_stat(filename) then
            return mod.read_file(filename)
          end
        end,
      },
    }
  end,
}

-- surround
-- https://github.com/nvim-mini/mini.surround
local mini_surround = {
  "nvim-mini/mini.surround",
  version = "*",

  opts = {
    mappings = {
      add = "gsa",
      delete = "gsd",
      find = "gsf",
      find_left = "gsF",
      highlight = "gsh",
      replace = "gsr",
      update_n_lines = "gsn",
    },
  },
}

-- integrate git
-- https://github.com/nvim-mini/mini-git
local mini_git = {
  "nvim-mini/mini-git",
  version = "*",
  main = "mini.git",
  cmd = {
    "Git",
  },
  event = {
    "BufReadPost",
  },
  keys = {
    {
      "<c-g>",
      function()
        require("mini.git").show_at_cursor()
      end,
      mode = { "v", "x", "o", "n" },
      desc = "Show git data",
    },
  },

  opts = {},
}

return {
  mini_splitjoin,
  mini_cursorword,
  mini_icons,
  mini_pairs,
  mini_snippets,
  mini_surround,
  mini_git,
}
