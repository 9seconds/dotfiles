local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local d = ls.dynamic_node


return {
  s({trig="^#!", regTrig=true, dscr="Shebang"}, {
    t("#!/usr/bin/"),
    i(1, "env"),
    d(2, function(args)
      if args[1][1] ~= "env" then
        return sn(nil, {
          t("")
        })
      end

      local filetype = vim.api.nvim_get_option_value("filetype", {})

      if filetype == "shell" then
        filetype = "bash"
      end

      return sn(nil, {
        t(" "),
        i(1, filetype)
      })
    end, {1})
  })
}
