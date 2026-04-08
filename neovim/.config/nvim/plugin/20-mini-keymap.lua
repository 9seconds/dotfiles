-- better escape and multistep keymapping
-- https://github.com/nvim-mini/mini.keymap

require("_.pack").add(
  "https://github.com/nvim-mini/mini.keymap",
  vim.version.range("*"),
  function()
    local combo = require("mini.keymap").map_combo
    local multi = require("mini.keymap").map_multistep

    -- map jk and kj to work exit insert and terminal modes
    combo(
      {"i", "c", "x", "s"},
      "jk",
      "<BS><BS><Esc>",
      {
        desc = "Exit insert mode"
      }
    )
    combo(
      {"i", "c", "x", "s"},
      "kj",
      "<BS><BS><Esc>",
      {
        desc = "Exit insert mode"
      }
    )

    combo(
      "t",
      "jk",
      "<BS><BS><C-\\><C-n>",
      {
        desc = "Exit insert mode"
      }
    )
    combo(
      "t",
      "kj",
      "<BS><BS><C-\\><C-n>",
      {
        desc = "Exit insert mode"
      }
    )

    -- fast save
    combo("n", "<leader><leader>", "<cmd>update<cr>", {desc = "Update file"})

    -- supertab
    multi(
      "i",
      "<Tab>",
      {
        "minisnippets_next",
        "blink_next",
        "minisnippets_expand",
        "jump_after_tsnode",
        "jump_after_close",
      }
    )
    multi(
      "i",
      "<S-Tab>",
      {
        "minisnippets_prev",
        "blink_prev",
        "jump_before_tsnode",
        "jump_before_open",
      }
    )

    -- integrate mini.pairs
    multi(
      "i",
      "<CR>",
      {
        "blink_accept",
        "minipairs_cr",
      }
    )
    multi(
      "i",
      "<BS>",
      {
        "minipairs_bs",
      }
    )

    -- gitsigns integration
    multi(
      {"n", "x"},
      "]h",
      {
        {
          condition = function()
            return package.loaded["gitsigns"] and not vim.wo.diff
          end,
          action = function()
            require("gitsigns").nav_hunk("next")
          end
        }
      }
    )
    multi(
      {"n", "x"},
      "[h",
      {
        {
          condition = function()
            return package.loaded["gitsigns"] and not vim.wo.diff
          end,
          action = function()
            require("gitsigns").nav_hunk("prev")
          end
        }
      }
    )
  end,
  true
)
