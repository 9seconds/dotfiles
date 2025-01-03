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
      goto_bottom = "",
    },
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

-- snippet management
-- https://github.com/echasnovski/mini.snippets
local mini_snippets = {
  "echasnovski/mini.snippets",
  version = "*",
  keys = {
    {
      "<c-j>",
      mode = "i",
    },
  },

  opts = function()
    local mod = require("mini.snippets")

    local function get_min_indent(current, next)
      if current == nil then
        return next
      end

      local min_length = #current
      if min_length > #next then
        min_length = #next
      end

      for idx = 1, min_length do
        if current:sub(idx, idx) ~= next:sub(idx, idx) then
          return current:sub(1, idx - 1)
        end
      end

      return current:sub(1, min_length)
    end

    local function get_selected_text()
      local lines = vim.split(vim.fn.trim(vim.fn.getreg('"'), "", 2), "\n")

      local min_indent = nil
      for _, line in ipairs(lines) do
        min_indent = get_min_indent(min_indent, line:match("^%s*"))
      end

      for idx, line in ipairs(lines) do
        lines[idx] = line:sub(#min_indent + 1)
      end

      return table.concat(lines, "\n")
    end

    return {
      mappings = {
        stop = "<c-k>",
      },

      expand = {
        insert = function(snippet, opts)
          opts = vim.tbl_deep_extend("force", opts or {}, {
            lookup = {
              ["NS_SELECTED_TEXT"] = get_selected_text(),
            },
          })

          return mod.default_insert(snippet, opts)
        end,
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

return {
  mini_bracketed,
  mini_splitjoin,
  mini_cursorword,
  mini_indentscope,
  mini_icons,
  mini_pairs,
  mini_snippets,
}
