-- treesitter configuration
-- https://github.com/nvim-treesitter/nvim-treesitter

local max_file_size_kb = 200 * 1024

local function disable_on_max_filesize(_, bufnr)
  return require("_.utils").get_buf_file_size(bufnr) >= 1024 * max_file_size_kb
end

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "JoosepAlviste/nvim-ts-context-commentstring",
  },

  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = "all",
      sync_install = true,

      -- :h nvim-treesitter-highlight-mod
      highlight = {
        enable = true,
        disable = disable_on_max_filesize,
      },

      -- see matchup.lua
      -- https://github.com/andymass/vim-matchup
      matchup = {
        enable = true,
        disable = disable_on_max_filesize,
      },

      -- :h nvim-treesitter-indentation-mod
      indent = {
        enable = true,
        disable = disable_on_max_filesize,
      },

      -- nvim-treesitter-textobjects
      -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
      textobjects = {
        select = {
          enable = true,
          disable = disable_on_max_filesize,

          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["ia"] = "@parameter.inner",
            ["aa"] = "@parameter.outer",
            ["ab"] = "@block.outer",
            ["ib"] = "@block.inner",
          },
        },
      },
    })
  end,
}
