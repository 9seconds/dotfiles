-- fast movement
-- https://codeberg.org/andyg/leap.nvim

vim.pack.add({
  "https://codeberg.org/andyg/leap.nvim",
})

vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap)")
vim.keymap.set({ "n", "x", "o" }, "S", function ()
  require("leap").visit({
    input = vim.fn.mode(true):match("o") and "" or "v",
  })
end)

vim.keymap.set({ "x", "o" }, "an", function ()
  require("leap.treesitter").select({
    opts = require("leap.user").with_traversal_keys("n", "N"),
  })
end)

vim.api.nvim_create_autocmd("User", {
  pattern = "VisitDone",
  group = vim.api.nvim_create_augroup("VisitorMode", {}),
  callback = function (event)
    if vim.v.operator == "y" and event.data.register == '"' then
      vim.cmd("normal! p")
    end
  end,
})
