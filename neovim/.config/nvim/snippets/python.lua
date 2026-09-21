local SYNTAX = {
  ["\"for\" loop"] = {
    prefix = "for",
    body = {
      "for ${2:item} in ${1:items}:",
      "\t${0:$TM_SELECTED_TEXT}",
    },
  },
  ["\"while\" loop"] = {
    prefix = {
      "wh",
      "while",
    },
    body = {
      "while ${1:True}:",
      "\t${0:$TM_SELECTED_TEXT}",
    },
  },
  ["\"with\" statement"] = {
    prefix = {
      "w",
      "with",
    },
    body = {
      "with ${1:context}:",
      "\t${0:$TM_SELECTED_TEXT}",
    },
  },
  ["Function definition"] = {
    prefix = "fn",
    body = {
      "def ${1:function}($4)${2: -> ${3:None}:}",
      "\t$0",
    },
  },
  ["Method definition"] = {
    prefix = "fnn",
    body = {
      "def ${1:function}(self${4:, $5})${2: -> ${3:None}:}",
      "\t$0",
    },
  },
  ["Static method definition"] = {
    prefix = "fns",
    body = {
      "@staticmethod",
      "def ${1:function}($4)${2: -> ${3:None}:}",
      "\t$0",
    },
  },
  ["Class method definition"] = {
    prefix = "fnc",
    body = {
      "@classmethod",
      "def ${1:function}(cls${4:, $5})${2: -> ${3:None}:}",
      "\t$0",
    },
  },
  ["import statement"] = {
    prefix = "im",
    body = "import $0",
  },
  ["\"from ... import\" statement"] = {
    prefix = "imm",
    body = "from $1 import $0",
  },
  ["insert breakpoint"] = {
    prefix = "b",
    body = {
      "$LINE_COMMENT FIXME($GIT_USERNAME): Remove before merge",
      "breakpoint()",
    },
  },
  ["insert conditional breakpoint"] = {
    prefix = "bb",
    body = {
      "$LINE_COMMENT FIXME($GIT_USERNAME): Remove before merge",
      "if $0:",
      "\tbreakpoint()",
    },
  },
  ["debug exception"] = {
    prefix = "be",
    body = {
      "$LINE_COMMENT FIXME($GIT_USERNAME): Remove before merge",
      "try:",
      "\t${0:$TM_SELECTED_TEXT}",
      "except Exception:",
      "\timport sys",
      "\te_type, exc, e_tb = sys.exc_info()",
      "\tbreakpoint()",
    },
  },
  ["double underscores"] = {
    prefix = "_",
    body = "__${0}__",
  },
  ["insert triple single quotes"] = {
    prefix = "3q",
    body = "'''$0'''",
  },
  ["insert triple double quotes"] = {
    prefix = "3qq",
    body = "\"\"\"$0\"\"\"",
  },
  ["comprehension"] = {
    prefix = "c",
    body = "${3:${2:item}} for $2 in ${1:items}$0",
  },
  ["comprehension with conditional"] = {
    prefix = "cc",
    body = "${3:${2:item}} for $2 in ${1:items} if ${4:$3}",
  },
  ["lambda function"] = {
    prefix = "l",
    body = "lambda ${1:item}: ${0:$1}",
  },
}

local UNITTEST = {
  ["assertEqual"] = {
    prefix = "ae",
    body = "self.assertEqual(${1:expected}, ${2:actual})",
  },
  ["assertNotEqual"] = {
    prefix = "ae_",
    body = "self.assertNotEqual(${1:expected}, ${2:actual})",
  },
  ["assertTrue"] = {
    prefix = "at",
    body = "self.assertTrue($1)",
  },
  ["assertFalse"] = {
    prefix = "at_",
    body = "self.assertFalse($1)",
  },
  ["assertIs"] = {
    prefix = "ais",
    body = "self.assertIs($1)",
  },
  ["assertIsNot"] = {
    prefix = "ais_",
    body = "self.assertIsNot($1)",
  },
  ["assertIsNone"] = {
    prefix = "ain",
    body = "self.assertIsNone($1)",
  },
  ["assertIsNotNone"] = {
    prefix = "ain_",
    body = "self.assertIsNotNone($1)",
  },
  ["assertIn"] = {
    prefix = "ai",
    body = "self.assertIn(${1:needle}, ${2:haystack})",
  },
  ["assertNotIn"] = {
    prefix = "ai_",
    body = "self.assertNotIn(${1:needle}, ${2:haystack})",
  },
  ["assertIsInstance"] = {
    prefix = "aii",
    body = "self.assertIsInstance(${1:obj}, ${2:class})",
  },
  ["assertIsNotInstance"] = {
    prefix = "aii_",
    body = "self.assertIsNotInstance(${1:obj}, ${2:class})",
  },
}

return vim.tbl_extend("error", SYNTAX, UNITTEST)
