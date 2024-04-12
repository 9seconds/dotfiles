-- breadcrumbs
-- https://github.com/SmiteshP/nvim-navic

local max_file_size = 100 * 1024

return {
  "SmiteshP/nvim-navic",
  dependencies = {
    "neovim/nvim-lspconfig",
  },
  event = {
    "BufReadPre",
  },

  config = function()
    require("nvim-navic").setup({
      lsp = {
        auto_attach = true,
      },
      separator = " / ",
      color_correction = "static",
      highlight = true,
    })

    vim.api.nvim_create_autocmd("BufRead", {
      group = vim.api.nvim_create_augroup("9_Navic", {}),
      callback = function()
        local utils = require("_.utils")
        vim.b.navic_lazy_update_context = utils.get_buf_file_size()
          > max_file_size
      end,
    })
  end,
}
