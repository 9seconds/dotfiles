-- advanced w/e/b motions
-- https://github.com/chrisgrieser/nvim-spider

return {
  "chrisgrieser/nvim-spider",
  keys = {
    {
      "w",
      function()
        return require("spider").motion("w")
      end,
      mode = { "n", "o", "x" },
      desc = "Spider W",
    },
    {
      "e",
      function()
        return require("spider").motion("e")
      end,
      mode = { "n", "o", "x" },
      desc = "Spider E",
    },
    {
      "b",
      function()
        return require("spider").motion("b")
      end,
      mode = { "n", "o", "x" },
      desc = "Spider B",
    },
  },

  opts = {},
}
