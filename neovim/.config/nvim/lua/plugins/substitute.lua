-- normal substitute
-- https://github.com/chrisgrieser/nvim-rip-substitute

return {
  "chrisgrieser/nvim-rip-substitute",
  cmd = "RipSubstitute",
  keys = {
    {
      "<leader>tr",
      function()
        require("rip-substitute").sub()
      end,
      mode = { "n", "x" },
      desc = " rip substitute",
    },
  },

  opts = {},
}
