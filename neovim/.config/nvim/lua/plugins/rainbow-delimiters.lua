-- make delimiters better
-- https://gitlab.com/HiPhish/rainbow-delimiters.nvim

local max_file_size = 120 * 1024


return {
  "HiPhish/rainbow-delimiters.nvim",
  version = "*",
  event = "BufReadPre",

  config = function()
    local rainbow_delimiters = require("rainbow-delimiters")
    local setup = require("rainbow-delimiters.setup")

    setup.setup({
      strategy = {
        [""] = rainbow_delimiters.strategy["global"],
        python = rainbow_delimiters.strategy["local"],
      },
    })

    vim.api.nvim_create_autocmd("BufRead", {
      group = vim.api.nvim_create_augroup("9_RainbowDelimiers", {}),
      callback = function()
        if require("_.utils").get_buf_file_size() < max_file_size then
          rainbow_delimiters.enable()
        else
          rainbow_delimiters.disable()
        end
      end,
      desc = "Disable or enable rainbow delimiters plugin",
    })
  end
}
