-- fancy guidelines
-- https://github.com/lukas-reineke/indent-blankline.nvim

local max_file_size = 50 * 1024

return {
  "lukas-reineke/indent-blankline.nvim",
  event = "VeryLazy",

  config = function()
    require("ibl").setup({
      use_treesitter = true,
      show_current_context = true,
      use_treesitter_scope = true,
    })

    local augroup = vim.api.nvim_create_augroup("9_IndentBlankline", {})
    vim.api.nvim_create_autocmd("BufRead", {
      group = augroup,
      callback = function()
        vim.b.indent_blankline_enabled = (
          require("_.utils").get_buf_file_size() < max_file_size
        )
      end,
      desc = "Disable or enable indent blankline plugin",
    })
  end,
}
