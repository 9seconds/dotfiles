-- git integration into main interface
-- https://github.com/lewis6991/gitsigns.nvim

local function keymap(name, key, func, mode)
  if not mode then
    mode = "n"
  end

  vim.keymap.set(
    mode,
    "<leader>g" .. key,
    func,
    {
      desc = "GitSigns: " .. name
    }
  )
end

require("_.pack").add(
  "https://github.com/lewis6991/gitsigns.nvim",
  vim.version.range("*"),
  function()
    require("gitsigns").setup({})

    keymap("Preview hunk", "P", function()
        require("gitsigns").preview_hunk()
    end)

    keymap("Preview hunk inline", "p", function()
        require("gitsigns").preview_hunk_inline()
    end)

    keymap("Blame line", "b", function()
        require("gitsigns").blame_line({ full = true })
    end)

    keymap("Blame file", "B", function()
        require("gitsigns").blame()
    end)

    keymap("Toggle current line blame", "l", function()
        require("gitsigns").toggle_current_line_blame()
    end)

    keymap("Toggle word diff", "w", function()
        require("gitsigns").toggle_word_diff()
    end)

    keymap("Reset hunk", "r", function()
        require("gitsigns").reset_hunk()
    end)

    keymap("Reset hunk", "r", function()
        require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, {"v", "s"})

    keymap("Reset whole buffer", "R", function()
        require("gitsigns").reset_buffer()
    end)

    vim.keymap.set(
      {"n", "x", "o", "s"},
      "ih",
      function()
        require("gitsigns").select_hunk()
      end,
      {
        desc = "GitSigns: Select hunk"
      }
    )
  end,
  {"BufRead", "BufNew"}
)
