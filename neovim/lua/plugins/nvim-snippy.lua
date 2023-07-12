-- snippets!
-- https://github.com/dcampos/nvim-snippy


return {
  "dcampos/nvim-snippy",
  keys = {
    {
      "<c-j>",
      function()
        if require("snippy").can_expand_or_advance() then
          return "<plug>(snippy-expand-or-advance)"
        end
        return "<c-j>"
      end,
      mode = {"i", "s"},
      expr = true,
    },
    {
      "<c-k>",
      function()
        if require("snippy").can_jump(-1) then
          return "<plug>(snippy-previous)"
        end
        return "<c-k>"
      end,
      mode = {"i", "s"},
      expr = true,
    },
    {
      "<tab>", "<plug>(snippy-cut-text)",
      mode = {"x"},
    },
  },
  event = "CmdlineEnter",
  ft = "snippets",

  opts = {}
}
