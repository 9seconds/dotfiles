-- git integration into main interface
-- https://github.com/lewis6991/gitsigns.nvim

vim.pack.add({
  {
    src = "https://github.com/lewis6991/gitsigns.nvim",
    version = vim.version.range("*"),
  },
})

local mod = require("gitsigns")
local leader_keymap = require("_.utils").keymap("GitSigns", "<leader>g")
local keymap = require("_.utils").keymap("GitSigns")

mod.setup({
  numhl = true,
  signcolumn = false,
})

leader_keymap("Preview hunk", "P", mod.preview_hunk)
leader_keymap("Preview hunk inline", "p", mod.preview_hunk_inline)

leader_keymap("Blame line", "b", function ()
  mod.blame_line({ full = true })
end)
leader_keymap("Blame file", "B", mod.blame)
leader_keymap("Toggle current line blame", "l", mod.toggle_current_line_blame)

leader_keymap("Toggle word diff", "w", mod.toggle_word_diff)

leader_keymap("Reset hunk", "r", mod.reset_hunk)
leader_keymap("Reset hunk", "r", function ()
  mod.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
end, { "v", "s" }
)
leader_keymap("Reset whole buffer", "R", mod.reset_buffer)

keymap("Select hunk", "ih", mod.select_hunk, { "n", "x", "o", "s" })
