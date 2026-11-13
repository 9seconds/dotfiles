-- fast movement
-- https://codeberg.org/andyg/leap.nvim

vim.pack.add({
  "https://codeberg.org/andyg/leap.nvim",
})

local keymap = require("_.utils").keymap("Leap")

keymap("Start", "s", "<Plug>(leap)", { "n", "x", "o" })
keymap("Jump to remote object with selection", "S", function ()
  require("leap").visit({
    input = vim.fn.mode(true):match("o") and "" or "v",
  })
end, { "n", "x", "o" }
)

keymap("Select by treesitter", "an", function ()
  require("leap.treesitter").select({
    opts = require("leap.user").with_traversal_keys("n", "N"),
  })
end, { "x", "o" }
)

vim.api.nvim_create_autocmd("User", {
  pattern = "VisitDone",
  group = vim.api.nvim_create_augroup("VisitorMode", {}),
  callback = function (event)
    if vim.v.operator == "y" and event.data.register == '"' then
      vim.cmd("normal! p")
    end
  end,
})
