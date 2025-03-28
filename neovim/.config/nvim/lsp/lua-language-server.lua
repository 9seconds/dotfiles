-- https://github.com/LuaLS/lua-language-server
-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/lua_ls.lua

return require("_.lsp").define("lua-language-server", {
  cmd = {
    "lua-language-server",
  },
  filetypes = {
    "lua",
  },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      workspace = {
        checkThirdParty = false,
        library = vim.api.nvim_get_runtime_file("", true),
      },
    },
  },
})
