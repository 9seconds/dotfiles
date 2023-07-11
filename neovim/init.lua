-- 9seconds Neovim Lua Config, V5
--
-- https://github.com/9seconds
-- https://neovim.io/doc/user/lua-guide.html


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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

require("_").setup()
require("lazy").setup("plugins")
