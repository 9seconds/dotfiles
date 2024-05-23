-- lsp niceties
-- https://github.com/nvimdev/lspsaga.nvim


return {
  "nvimdev/lspsaga.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  event = {
    "LspAttach",
  },
  keys = {
    {
      "<leader>lc",
      "<cmd>:Lspsaga code_action<cr>",
      mode = {"n", "v"},
      desc = "Get code actions",
    },
    {
      "<leader>lf",
      "<cmd>:Lspsaga finder<cr>",
      desc = "Find a symbol",
    },
  },

  opts = {
    symbol_in_winbar = {
      enable = true,
      hide_keyword = true,
    },
    code_action = {
      show_server_name = true,
      extend_gitsigns = true,
    },
    ligthbulb = {
      virtual_text = false,
    }
  }
}
