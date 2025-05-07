-- 9seconds Neovim Lua Config, V5
--
-- https://github.com/9seconds
-- https://neovim.io/doc/user/lua-guide.html

vim.loader.enable()

local datapath = vim.fn.stdpath("data") .. "/lazy"
local lazypath = datapath .. "/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("_")
require("_.options")
require("_.lsp")

vim.api.nvim_create_autocmd({ "User" }, {
  once = true,
  pattern = "VeryLazy",
  callback = function()
    require("_.keymappings")
    require("_.autocommands")
    require("_.commands")
    require("_.terminal")

    if vim.g.neovide then
      require("_.neovide")
    end
  end,
})

require("lazy").setup("plugins", {
  root = datapath,
  lockfile = datapath .. "/lazy-lock.json",
  dev = {
    path = "~/.nvim-plugins",
    patterns = { "9seconds" },
    fallback = true,
  },
  performance = {
    cache = {
      enabled = true,
    },
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
