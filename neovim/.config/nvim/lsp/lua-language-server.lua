-- https://github.com/LuaLS/lua-language-server
-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/lua_ls.lua

return require("_.lsp").define("lua-language-server", {
  cmd = {
    "lua-language-server",
  },
  filetypes = {
    "lua",
  },
})
