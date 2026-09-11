return {
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
  ["Function definition"] = {
    prefix = "fn",
    body = {
      "def ${1:function}($4)${2: -> ${3:None}:}",
      "\t$0",
    },
  },
  ["Method definition"] = {
    prefix = "fnm",
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
    body = "breakpoint()",
  },
  ["insert conditional breakpoint"] = {
    prefix = "bb",
    body = {
      "if $1:",
      "\tbreakpoint()$0",
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
