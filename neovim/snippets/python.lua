local ls = require("luasnip")
local extras = require("luasnip.extras")

local s = ls.snippet
local f = ls.function_node
local sn = ls.snippet_node
local d = ls.dynamic_node
local c = ls.choice_node
local rep = extras.rep


local function is_method()
  local scope = require("_snippet_utils").get_ts_scope_at_cursor()

  if #scope < 2 then
    return false
  end

  if scope[2]:type() == "class_definition" then
    return true
  end

  return false
end


local function build_function_name(args)
  local snippet_utils = require("_snippet_utils")

  return args[1][1] .. "(" .. snippet_utils.concat_multiline(args[2]) .. ")"
end


local function snip_try_body()
  return sn(nil, {
    t({"", "\t"}),
    i(1, "return"),
  })
end


local function snip_except_body()
  local function has_comma(args)
    local concat = require("_snippet_utils").concat_multiline

    if concat(args):find(",") then
      return true
    end
    return false
  end

  return sn(nil, {
    t({"", "except "}),
    f(function(args)
      if has_comma(args[1]) then
        return "("
      end
      return ""
    end, {1}),
    i(1, "Exception"),
    f(function(args)
      if has_comma(args[1]) then
        return ")"
      end
      return ""
    end, {1}),
    c(2, {
      t(":"),
      d(1, function()
        return sn(nil, {
          t(" as "),
          i(1, "exc"),
          t(":")
        })
      end)
    }),
    t({"", "\t"}),
    i(1, "pass")
  })
end

local function snip_finally_body()
  return sn(nil, {
    t({"", "finally:", "\t"}),
    i(1, "pass")
  })
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
      local snippet_utils = require("_snippet_utils")

      if not is_method() then
        return sn(nil, {})
      end

      local params = vim.tbl_map(snippet_utils.trim_space, vim.split(args[1][1], ","))
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
        return sn(nil, {i(1, "self")})
      end

      return sn(nil, {i(1)})
    end, {2}),
    t("):"),
    t({"", "\t"}),
    i(1, "pass")
  }),

  s({trig="dec", dscr="Simple decorator"}, {
    t("def "),
    i(1, "function"),
    t("("),
    i(2, "func"),
    t({"):", "\t@"}),
    i(3, "functools.wraps"),
    t("("),
    rep(2),
    t({")", "\tdef "}),
    i(4, "decorator"),
    t("("),
    i(5, "*args, **kwargs"),
    t({"):", "\t\trv = "}),
    f(build_function_name, {2, 5}),
    t({"", "\t\t"}),
    i(6, "return rv"),
    t({"", "", "\treturn "}),
    rep(4),
  }),

  s({trig="decc", dscr="Complex decorator"}, {
    t("def "),
    i(1, "function"),
    t("("),
    i(2, "arg"),
    t({"):", "\tdef "}),
    i(3, "inner_decorator"),
    t("("),
    i(4, "func"),
    t({"):", "\t\t@"}),
    i(5, "functools.wraps"),
    t("("),
    rep(4),
    t({")", "\t\tdef "}),
    i(6, "outer_decorator"),
    t("("),
    i(7, "*args, **kwargs"),
    t({"):", "\t\t\trv = "}),
    f(build_function_name, {4, 7}),
    t({"", "\t\t\t"}),
    i(8, "return rv"),
    t({"", "", "\t\treturn "}),
    rep(6),
    t({"", "\treturn "}),
    rep(3),
  }),

  s({trig="tryex", dscr="Try/except/finally"}, {
    t("try:"),
    d(1, snip_try_body),
    d(2, snip_except_body),
  }),

  s({trig="tryfi", dscr="Try/except/finally"}, {
    t("try:"),
    d(1, snip_try_body),
    d(2, snip_finally_body),
  }),

  s({trig="tryexfi", dscr="Try/except/finally"}, {
    t("try:"),
    d(1, snip_try_body),
    d(2, snip_except_body),
    d(3, snip_finally_body),
  }),
}
