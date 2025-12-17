-- git integration into main interface
-- https://github.com/lewis6991/gitsigns.nvim

return {
  "lewis6991/gitsigns.nvim",
  event = {
    "BufRead",
    "BufNew",
  },
  cmd = "GitSign",
  keys = {
    {
      "]h",
      function()
        if vim.wo.diff then
          vim.cmd.normal({ "]h", bang = true })
        else
          require("gitsigns").nav_hunk("next")
        end
      end,
      desc = "GitSign: Next hunk",
    },
    {
      "[h",
      function()
        if vim.wo.diff then
          vim.cmd.normal({ "]h", bang = true })
        else
          require("gitsigns").nav_hunk("prev")
        end
      end,
      desc = "GitSign: Prev hunk",
    },
    {
      "<leader>gP",
      function()
        require("gitsigns").preview_hunk()
      end,
      desc = "GitSign: Preview hunk",
    },
    {
      "<leader>gp",
      function()
        require("gitsigns").preview_hunk_inline()
      end,
      desc = "GitSign: Preview hunk inline",
    },
    {
      "<leader>gb",
      function()
        require("gitsigns").blame_line({ full = true })
      end,
      desc = "GitSign: Blame line",
    },
    {
      "<leader>gB",
      function()
        require("gitsigns").blame()
      end,
      desc = "GitSign: Blame file",
    },
    {
      "<leader>gl",
      function()
        require("gitsigns").toggle_current_line_blame()
      end,
      desc = "GitSign: Toggle current line blame",
    },
    {
      "<leader>gw",
      function()
        require("gitsigns").toggle_word_diff()
      end,
      desc = "GitSign: Toggle word diff",
    },
    {
      "ih",
      function()
        require("gitsigns").select_hunk()
      end,
      mode = { "o", "x" },
      desc = "GitSign: Select hunk",
    },
    {
      "<leader>gr",
      function()
        require("gitsigns").reset_hunk()
      end,
      desc = "GitSign: Reset hunk",
    },
    {
      "<leader>gr",
      function()
        require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end,
      mode = { "v" },
      desc = "GitSign: Reset hunk",
    },
    {
      "<leader>gR",
      function()
        require("gitsigns").reset_buffer()
      end,
      desc = "GitSign: Reset whole buffer",
    },
  },

  opts = {},
}
