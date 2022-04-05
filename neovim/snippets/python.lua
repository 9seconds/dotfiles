local ls = require("luasnip")
local extras = require("luasnip.extras")
local ts_locals = require("nvim-treesitter.locals")
local ts_utils = require("nvim-treesitter.ts_utils")

local s = ls.snippet
local f = ls.function_node
local sn = ls.snippet_node
local d = ls.dynamic_node
local c = ls.choice_node
local rep = extras.rep


local function is_method()
  local cursor_node = ts_utils.get_node_at_cursor()
  local scope = ts_locals.get_scope_tree(cursor_node, 0)

  if #scope < 2 then
    return false
  end

  if scope[2]:type() == "class_definition" then
    return true
  end

  return false
end

local function split_params(text)
  local chunks = vim.split(text, ",")

  for i, v in ipairs(chunks) do
    chunks[i] = v:gsub("^%s+", ""):gsub("%s+$", "")
  end

  return chunks
end


return {
  s({trig="pdb", dscr="Breakpoint"}, {
    t("import "),
    c(1, {
      t("pdb"),
      t("ipdb")
    }),
    t("; "),
    rep(1),
    t(".set_trace()")
  }),

  s({trig="def", dscr="Definition"}, {
    d(1, function(args)
      -- prepend function signature with a class/staticmethod decorators
      if not is_method() then
        return sn(nil, {})
      end

      local params = split_params(args[1][1])
      if params[1] == "cls" then
        return sn(nil, {
          t({"@classmethod", ""})
        })
      elseif params[1] ~= "self" then
        return sn(nil, {
          t({"@staticmethod", ""})
        })
      end

      return sn(nil, {})
    end, {3}),

    t("def "),
    i(2, "function"),

    f(function(args)
      -- append a double-under at the end of the function
      if vim.startswith(args[1][1], "__") then
        return "__"
      end
      return ""
    end, {2}),

    t("("),
    d(3, function(args)
      if is_method() then
        return sn(nil, {
          i(1, "self")
        })
      end

      return sn(nil, {i(1)})
    end, {2}),
    t("):"),
    t({"", "\t"}),
    i(0, "pass")
  }),

  s({trig="sup", dscr="super()"}, {
    d(1, function()
      local cursor_node = ts_utils.get_node_at_cursor()
      local scope = ts_locals.get_scope_tree(cursor_node, 0)

      local classname = ""
      for _, v in pairs(scope) do
        if v:type() == "class_definition" then
          _, _, classname = ts_utils.get_node_text(v)[1]:find("class%s+(%a+)[(:]")
          break
        end
      end

      local functionname
      local params = {}

      for _, v in pairs(scope) do
        if v:type() == "function_definition" then
          local text = table.concat(ts_utils.get_node_text(v), " ")
          text = text:sub(1, text:find(":", 1, {plain=true}))

          _, j, functionname = text:find("def%s+([_a-zA-Z0-9]+)")
          params = split_params(text:sub(j+2, #text-2))
          break
        end
      end

      local super_nodes = {}
      if classname and #params > 0 then
        table.insert(super_nodes, i(nil, classname .. ", " .. params[1]))
      end
      table.insert(super_nodes, t(""))

      if not (classname and functionname and params and #params > 0) then
        return sn(nil, t("sup"))
      end

      local func_params = {}
      for i=2, #params do
        func_params[i-1] = params[i]
      end

      return sn(nil, {
        t("super("),
        c(1, {
          t(classname .. ", " .. params[1]),
          t("")
        }),
        t(")." .. functionname .. "("),
        i(2, table.concat(func_params, ", ")),
        t(")")
      })
    end)
  })
}
