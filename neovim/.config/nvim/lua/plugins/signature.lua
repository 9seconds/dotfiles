-- good looking signature
-- https://github.com/ray-x/lsp_signature.nvim

return {
  "ray-x/lsp_signature.nvim",

  config = function()
    require("lsp_signature").setup({
      hint_enable = false,
      hint_prefix = "",
      handler_opts = {
        border = "none",
      },
    })

    vim.keymap.set("n", "<leader>lx", function()
      require("lsp_signature").toggle_float_win()
    end, { desc = "Show signature in floating window" })
  end,
}
