-- floating statusline
-- https://github.com/b0o/incline.nvim

return {
  "b0o/incline.nvim",
  dependencies = {
    "SmiteshP/nvim-navic",
  },
  event = "VeryLazy",

  opts = {
    render = function(props)
      local navic = require("nvim-navic")
      local rv = {}

      if not (props.focused and navic.is_available(props.buf)) then
        return rv
      end

      for i, v in ipairs(navic.get_data(props.buf) or {}) do
        local el = {}

        if i ~= 1 then
          table.insert(el, { " > ", group = "NavicSeparator" })
        end

        table.insert(el, { v.icon, group = "NavicIcons" .. v.type })
        table.insert(el, { v.name, group = "NavicText" })
        table.insert(rv, el)
      end

      return rv
    end,
  },
}
