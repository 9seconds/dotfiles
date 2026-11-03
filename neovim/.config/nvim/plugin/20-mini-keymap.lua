-- better escape and multistep keymapping
-- https://github.com/nvim-mini/mini.keymap

vim.pack.add({
  {
    src = "https://github.com/nvim-mini/mini.keymap",
    version = vim.version.range("*"),
  },
})

local function is_blank_line()
  local line = vim.api.nvim_get_current_line()
  return line:find("^%s*$") ~= nil
end

local function is_gitsigns_active()
  return package.loaded["gitsigns"] and not vim.wo.diff
end

local combo = require("mini.keymap").map_combo
local multi = require("mini.keymap").map_multistep

-- map jk and kj to work exit insert and terminal modes
combo({ "i", "c", "x", "s" }, "jk", "<BS><BS><Esc>", {
  desc = "Exit insert mode",
})
combo({ "i", "c", "x", "s" }, "kj", "<BS><BS><Esc>", {
  desc = "Exit insert mode",
})

combo("t", "jk", "<BS><BS><C-\\><C-n>", {
  desc = "Exit insert mode",
})
combo("t", "kj", "<BS><BS><C-\\><C-n>", {
  desc = "Exit insert mode",
})

-- supertab
multi("i", "<Tab>", {
  {
    condition = is_blank_line,
    action = function ()
      vim.api.nvim_feedkeys("\t", "n", false)
    end,
  },
  "minisnippets_next",
  "blink_next",
  "jump_after_tsnode",
  "jump_after_close",
})
multi("i", "<S-Tab>", {
  "minisnippets_prev",
  "blink_prev",
  "jump_before_tsnode",
  "jump_before_open",
})

-- integrate mini.pairs
multi("i", "<CR>", {
  "blink_accept",
  "minipairs_cr",
})
multi("i", "<S-CR>", {
  "minipairs_cr",
})
multi("i", "<BS>", {
  "minipairs_bs",
})

-- gitsigns integration
multi({ "n", "x" }, "]h", {
  {
    condition = is_gitsigns_active,
    action = function ()
      require("gitsigns").nav_hunk("next")
    end,
  },
})
multi({ "n", "x" }, "[h", {
  {
    condition = is_gitsigns_active,
    action = function ()
      require("gitsigns").nav_hunk("prev")
    end,
  },
})
