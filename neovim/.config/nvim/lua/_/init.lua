-- initialize settings

local M = {}

function M.setup()
  require("_.keymappings").setup()
  require("_.options").setup()
  require("_.autocommands").setup()
  require("_.commands").setup()
  require("_.terminal").setup()
  require("_.exrc").setup()

  if vim.g.neovide then
    require("_.neovide").setup()
  end
end

return M
