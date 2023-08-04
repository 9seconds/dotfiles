-- git integration
-- https://github.com/lewis6991/gitsigns.nvim


return {
  "lewis6991/gitsigns.nvim",
  event = "VeryLazy",

  config = function()
    local gitsigns = require("gitsigns")

    gitsigns.setup({
      on_attach = function(bufnr)
        vim.keymap.set("n", "]c", function()
          if vim.wo.diff then
            return "]c"
          end

          vim.schedule(gitsigns.next_hunk)

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

          vim.schedule(gitsigns.prev_hunk)

          return "<Ignore>"
        end, {
          buffer = bufnr,
          expr = true,
          noremap = false,
        })

        vim.keymap.set(
          "n",
          "<leader>hr",
          function()
            vim.schedule(gitsigns.reset_hunk)
          end,
          {desc = "Reset git hunk", buffer = bufnr}
        )
        vim.keymap.set(
          "v",
          "<leader>hr",
          function()
            vim.schedule(function()
              gitsigns.reset_hunk({
                vim.fn.line("."),
                vim.fn.line("v"),
              })
            end)
          end,
          {desc = "Reset git hunk", buffer = bufnr}
        )

        vim.keymap.set(
          "n",
          "<leader>hp",
          function()
            vim.schedule(gitsigns.preview_hunk)
          end,
          {desc = "Preview git hunk", buffer = bufnr}
        )

        vim.keymap.set(
          "n",
          "<leader>hb",
          function()
            vim.schedule(function()
              gitsigns.blame_line({
                full = true,
                ignore_whitespace = true,
              })
            end)
          end,
          {desc = "Git blame this line", buffer = bufnr}
        )
        vim.keymap.set(
          "n",
          "<leader>hd",
          gitsigns.toggle_deleted,
          {desc = "Toggle deleted lines", buffer = bufnr}
        )
      end
    })

    local null_ls = require("null-ls")

    null_ls.register({
      null_ls.builtins.code_actions.gitsigns
    })
  end
}
