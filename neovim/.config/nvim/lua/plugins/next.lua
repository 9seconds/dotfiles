-- repeatable movements
-- https://github.com/ghostbuster91/nvim-next

local DIAG_OPTS = {
  severity = {
    min = vim.diagnostic.severity.WARN,
  },
}

local function ts_goto(action)
  return function()
    local ts_utils = require("nvim-treesitter.ts_utils")

    local node = ts_utils.get_node_at_cursor(0)
    if not node then
      return
    end

    node = ts_utils[action](node, true, true)
    if not node then
      return
    end

    ts_utils.goto_node(node, false, true)
  end
end

local function vim_cmd(action)
  return function()
    local status = pcall(vim.cmd, action)
    if not status then
      vim.notify("No more items", vim.log.levels.INFO)
    end
  end
end

return {
  "ghostbuster91/nvim-next",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  keys = {
    "f",
    "F",
    "t",
    "T",
    ";",
    ",",
    "[q",
    "]q",
    "[d",
    "]d",
    "[l",
    "]l",
    "[t",
    "]t",
  },

  opts = function()
    local builtins = require("nvim-next.builtins")

    return {
      default_mappings = {
        repeat_style = "original",
      },
      items = {
        builtins.f,
        builtins.t,
      },
    }
  end,

  config = function()
    local builtins = require("nvim-next.builtins")
    local int_qf = require("nvim-next.integrations.quickfix")()
    local int_diag = require("nvim-next.integrations.diagnostic")()
    local next_move = require("nvim-next.move")

    require("nvim-next").setup({
      default_mappings = {
        repeat_style = "original",
      },
      items = {
        builtins.f,
        builtins.t,
      },
    })

    local function map(key, action_forward, action_backward, desc)
      vim.keymap.set(
        { "n", "x", "o" },
        "[" .. key,
        action_backward,
        { desc = "Previous " .. desc }
      )
      vim.keymap.set(
        { "n", "x", "o" },
        "]" .. key,
        action_forward,
        { desc = "Next " .. desc }
      )
    end

    map("q", int_qf.cnext, int_qf.cprevious, "quickfix item")
    map(
      "d",
      int_diag.goto_next(DIAG_OPTS),
      int_diag.goto_prev(DIAG_OPTS),
      "diagnostic item"
    )

    local prev_loc, next_loc =
      next_move.make_repeatable_pair(vim_cmd("lprevious"), vim_cmd("lnext"))
    local prev_ts, next_ts = next_move.make_repeatable_pair(
      ts_goto("get_previous_node"),
      ts_goto("get_next_node")
    )

    map("l", next_loc, prev_loc, "location item")
    map("t", next_ts, prev_ts, "treesitter item")
  end,
}
