local ls = require("luasnip")

local s = ls.snippet
local sn = ls.snippet_node
local d = ls.dynamic_node
local f = ls.function_node


local function make_special_comment(title)
  return function()
      local snippet_utils = require("_snippet_utils")
      local utils = require("_utils")

      local fmt_string = vim.api.nvim_get_option_value("cms", {}) or "# %s"
      local git_config = utils.git_config()
      local name = vim.tbl_get(git_config, "user", "name")

      local nodes = {t(title)}
      if name then
        table.insert(nodes, f(function(args)
          if args[1][1] ~= "" then
            return "("
          end
          return ""
        end, {1}))
        table.insert(nodes, i(1, name))
        table.insert(nodes, f(function(args)
          if args[1][1] ~= "" then
            return ")"
          end
          return ""
        end, {1}))
      end

      table.insert(nodes, t(": "))
      table.insert(nodes, i(2))

      local cms_chunks = vim.split(fmt_string, "%s", {plain=true})
      if #cms_chunks > 1 then
        for _, v in ipairs(vim.list_slice(cms_chunks, 2)) do
          table.insert(nodes, t(v))
        end
        table.insert(nodes, 1, t(cms_chunks[1]))
      end

      return sn(nil, nodes)
  end
end


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
  }),

  s({trig="#T", dscr="TODO comment"}, {
    d(1, make_special_comment("TODO"))
  }),

  s({trig="#F", dscr="FIXME comment"}, {
    d(1, make_special_comment("FIXME"))
  })
}
