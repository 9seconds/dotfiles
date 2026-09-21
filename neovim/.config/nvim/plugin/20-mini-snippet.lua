-- snippet support
-- https://github.com/nvim-mini/mini.snippets

local VARS = {
  GIT_USERNAME = function ()
    local proc = vim.system({ "git", "config", "user.name" }, { text = true })
    local result = proc:wait(1000)
    return vim.trim(result.stdout or "")
  end,
  GIT_EMAIL = function ()
    local proc = vim.system({ "git", "config", "user.email" }, { text = true })
    local result = proc:wait(1000)
    return vim.trim(result.stdout or "")
  end,
}

vim.pack.add({
  {
    src = "https://github.com/nvim-mini/mini.snippets",
    version = "stable",
  },
})

local mod = require("mini.snippets")

mod.setup({
  expand = {
    insert = function (snippet)
      local vars = vim.tbl_extend("error", VARS, vim.g.nineseconds_mini_snippets or {})
      return mod.default_insert(snippet, {
        lookup = vim.tbl_map(function (value) return value() end, vars),
      })
    end,
  },
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
