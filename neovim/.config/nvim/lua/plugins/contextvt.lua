-- display context of the function at the end
-- https://github.com/haringsrob/nvim_context_vt


return {
  "haringsrob/nvim_context_vt",
  dependencies = {
    "nvim-treesitter/nvim-treesitter"
  },
  main = "nvim_context_vt",
  keys = {
    {"<leader>v", ":NvimContextVtToggle<cr>"}
  },

  opts = {
    enabled = false,
  }
}
