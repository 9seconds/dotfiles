-- 9seconds Neovim Lua Config, V6
--
-- https://github.com/9seconds
-- https://neovim.io/doc/user/lua-guide.html

-- https://neovim.io/doc/user/lua/#vim.loader.enable()
vim.loader.enable()

-- https://neovim.io/doc/user/lua/#ui2
require("vim._core.ui2").enable({
  enable = true,
})

require("_.project_root")
require("_.options")
require("_.keymappings")
require("_.autocommands")
require("_.lsp")

vim.schedule(function()
  require("_.commands")
end)
