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
      desc = "Expand or advance snippet",
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
      desc = "Jump to the previous snippet position",
    },
    {
      "<tab>",
      "<plug>(snippy-cut-text)",
      mode = {"x"},
      desc = "Cut text for the snippet",
    },
  },
  cmd = { "SnippyEdit", "SnippyReload" },
  ft = "snippets",

  opts = {}
}
