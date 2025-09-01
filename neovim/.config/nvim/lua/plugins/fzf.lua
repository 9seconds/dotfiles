-- fuzzy finder. faster than telescope on leblon, so be it
-- https://github.com/ibhagwan/fzf-lua

return {
  "ibhagwan/fzf-lua",
  cond = vim.fn.executable("fzf"),
  dependencies = {
    "nvim-mini/mini.icons",
  },
  keys = {
    {
      "<leader>tt",
      function()
        return require("fzf-lua").global({})
      end,
      desc = "FZF: Global picker",
    },
    {
      "<leader>tG",
      function()
        return require("fzf-lua").grep_cword({})
      end,
      desc = "FZF: Grep a word",
    },
    {
      "<leader>tg",
      function()
        return require("fzf-lua").live_grep({})
      end,
      desc = "FZF: Grep",
    },
    {
      "<leader>ts",
      function()
        return require("fzf-lua").git_status({})
      end,
      desc = "FZF: Git status",
    },
    {
      "<leader>tZ",
      function()
        return require("fzf-lua").grep_curbuf({})
      end,
      desc = "FZF: Grep current buffer",
    },
    {
      "<leader>tr",
      function()
        return require("fzf-lua").lsp_references({})
      end,
      desc = "FZF: LSP references",
    },
    {
      "<leader>tc",
      function()
        return require("fzf-lua").lsp_incoming_calls({})
      end,
      desc = "FZF: LSP incoming calls",
    },
    {
      "<leader>tC",
      function()
        return require("fzf-lua").lsp_outgoing_calls({})
      end,
      desc = "FZF: LSP outgoing calls",
    },
    {
      "<leader>tz",
      function()
        return require("fzf-lua").treesitter({})
      end,
      desc = "FZF: Current treesitter symbols",
    },
  },
  cmd = {
    "FzfLua",
  },

  opts = {
    'fzf-native',
    fzf_colors = true,
  },
}
