-- better escape and multistep keymapping
-- https://github.com/nvim-mini/mini.keymap

vim.pack.add({
  {
    src = "https://github.com/nvim-mini/mini.keymap",
    version = vim.version.range("*"),
  },
})

local function is_copilot_active()
  return package.loaded["blink.cmp"] and vim.g.copilot_mode
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
  "minisnippets_next",
  {
    condition = is_copilot_active,
    action = function()
      return require("blink.cmp").select_next() or false
    end,
  },
  "blink_next",
  "jump_after_tsnode",
  "jump_after_close",
})
multi("i", "<S-Tab>", {
  "minisnippets_prev",
  {
    condition = is_copilot_active,
    action = function()
      return require("blink.cmp").select_prev() or false
    end,
  },
  "blink_prev",
  "jump_before_tsnode",
  "jump_before_open",
})

-- integrate mini.pairs
multi("i", "<CR>", {
  {
    condition = is_copilot_active,
    action = function()
      return require("blink.cmp").accept() or false
    end,
  },
  "blink_accept",
  "minipairs_cr",
})
multi("i", "<BS>", {
  "minipairs_bs",
})

-- gitsigns integration
multi({ "n", "x" }, "]h", {
  {
    condition = is_gitsigns_active,
    action = function()
      require("gitsigns").nav_hunk("next")
    end,
  },
})
multi({ "n", "x" }, "[h", {
  {
    condition = is_gitsigns_active,
    action = function()
      require("gitsigns").nav_hunk("prev")
    end,
  },
})
