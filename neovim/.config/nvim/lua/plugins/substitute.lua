-- substitute
-- https://github.com/gbprod/substitute.nvim

local SUBSTITUTION_REGISTER = "s"

return {
  "gbprod/substitute.nvim",
  keys = {
    {
      "r",
      function()
        require("substitute").operator({
          register = SUBSTITUTION_REGISTER,
          modifiers = { "trim" },
        })
      end,
      mode = "n",
      desc = "Substitute a motion",
    },
    {
      "rr",
      function()
        require("substitute").line({
          register = SUBSTITUTION_REGISTER,
          modifiers = { "reindent" },
        })
      end,
      mode = "n",
      desc = "Substitute whole line",
    },
    {
      "R",
      function()
        require("substitute").eol({
          register = SUBSTITUTION_REGISTER,
          modifiers = { "trim" },
        })
      end,
      mode = "n",
      desc = "Substitute until end of line",
    },
    {
      "r",
      function()
        require("substitute").visual({
          register = SUBSTITUTION_REGISTER,
          modifiers = { "trim" },
        })
      end,
      mode = "x",
      desc = "Substitute visual selection",
    },

    {
      "<leader>r",
      function()
        require("substitute.range").operator({
          register = SUBSTITUTION_REGISTER,
        })
      end,
      mode = "n",
      desc = "Substitute within a range",
    },
    {
      "<leader>r",
      function()
        require("substitute.range").visual({
          register = SUBSTITUTION_REGISTER,
        })
      end,
      mode = "x",
      desc = "Substitute within a visual range",
    },
    {
      "<leader>rr",
      function()
        require("substitute.range").word({
          register = SUBSTITUTION_REGISTER,
        })
      end,
      mode = "x",
      desc = "Substitute a word within a visual range",
    },

    {
      "rx",
      function()
        require("substitute.exchange").operator({
          register = SUBSTITUTION_REGISTER,
        })
      end,
      mode = "n",
      desc = "Exchange a word",
    },
    {
      "rxx",
      function()
        require("substitute.exchange").line({
          register = SUBSTITUTION_REGISTER,
        })
      end,
      mode = "n",
      desc = "Exchange a line",
    },
    {
      "X",
      function()
        require("substitute.exchange").visual({
          register = SUBSTITUTION_REGISTER,
        })
      end,
      mode = "n",
      desc = "Exchange a visual selection",
    },
  },

  opts = {},
}
