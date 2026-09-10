-- snippet support
-- https://github.com/nvim-mini/mini.snippets

vim.pack.add({
  {
    src = "https://github.com/nvim-mini/mini.snippets",
    version = "stable",
  },
})

local mod = require("mini.snippets")

mod.setup({
  snippets = {
    mod.gen_loader.from_file(vim.fs.joinpath(vim.fn.stdpath("config"), "snippets", "_.lua")),
    mod.gen_loader.from_lang(),
    mod.gen_loader.from_file(vim.fs.joinpath(".snippets", "_.lua")),
    function (ctx)
      local filename = vim.fs.joinpath(".snippets", ctx.lang .. ".lua")
      if vim.uv.fs_stat(filename) then
        return mod.read_file(filename)
      end
    end,
  },
})
