-- paint parens in different colors
-- https://gitlab.com/HiPhish/rainbow-delimiters.nvim


local big_size = 30 * 1024
local max_file_size = 80 * 1024


return {
  url = "https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter"
  },
  event = "BufReadPre",

  config = function()
    vim.g.rainbow_delimiters = {
      strategy = {
        [""] = function()
          local strategies = require("rainbow-delimiters").strategy
          local file_size = require("_.utils").get_buf_file_size()

          if file_size >= max_file_size then
            return nil
          elseif file_size >= big_size then
            return strategies["global"]
          end

          return strategies["local"]
        end
      }
    }
  end
}
