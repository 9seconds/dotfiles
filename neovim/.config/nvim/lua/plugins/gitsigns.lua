-- git integration
-- https://github.com/lewis6991/gitsigns.nvim

return {
  "lewis6991/gitsigns.nvim",
  version = "*",
  dependencies = {
    "ghostbuster91/nvim-next",
  },
  event = "VeryLazy",

  opts = {
    on_attach = function(bufnr)
      local gitsigns = require("gitsigns")
      local nngs = require("nvim-next.integrations").gitsigns(gitsigns)

      vim.keymap.set("n", "]c", function()
        if vim.wo.diff then
          return "]c"
        end

        vim.schedule(nngs.next_hunk)

        return "<Ignore>"
      end, {
        buffer = bufnr,
        expr = true,
        noremap = false,
      })
      vim.keymap.set("n", "[c", function()
        if vim.wo.diff then
          return "[c"
        end

        vim.schedule(nngs.prev_hunk)

        return "<Ignore>"
      end, {
        buffer = bufnr,
        expr = true,
        noremap = false,
      })

      vim.keymap.set("n", "<leader>hr", function()
        vim.schedule(gitsigns.reset_hunk)
      end, { desc = "Reset git hunk", buffer = bufnr })

      vim.keymap.set("v", "<leader>hr", function()
        vim.schedule(function()
          gitsigns.reset_hunk({
            vim.fn.line("."),
            vim.fn.line("v"),
          })
        end)
      end, { desc = "Reset git hunk", buffer = bufnr })

      vim.keymap.set("n", "<leader>hp", function()
        vim.schedule(gitsigns.preview_hunk)
      end, { desc = "Preview git hunk", buffer = bufnr })

      vim.keymap.set("n", "<leader>ht", function()
        vim.schedule(gitsigns.toggle_current_line_blame)
      end, { desc = "Toggle git blame line", buffer = bufnr })

      vim.keymap.set("n", "<leader>hb", function()
        vim.schedule(function()
          gitsigns.blame_line({
            full = true,
            ignore_whitespace = true,
          })
        end)
      end, { desc = "Git blame this line", buffer = bufnr })

      vim.keymap.set(
        "n",
        "<leader>hd",
        gitsigns.toggle_deleted,
        { desc = "Toggle deleted lines", buffer = bufnr }
      )
    end,
  },
}
