return {
  {
    desc = "for loop",
    prefix = "for",
    body = {
      "for ${2:item} in ${1:items}:",
      "    $0"
    },
  },
  {
    desc = "while loop",
    prefix = {"wh", "while"},
    body = {
      "while ${1:True}:",
      "    $0"
    },
  },
  {
    desc = "function definition",
    prefix = "fnn",
    body = {
      "def ${1:function}($4)${2: -> ${3:None}:}",
      "    $0"
    },
  },
  {
    desc = "method definition",
    prefix = "fnm",
    body = {
      "def ${1:function}(self${4:, $5})${2: -> ${3:None}:}",
      "    $0"
    },
  },
  {
    desc = "static method definition",
    prefix = "fns",
    body = {
      "@staticmethod",
      "def ${1:function}($4)${2: -> ${3:None}:}",
      "    $0"
    },
  },
  {
    desc = "class method definition",
    prefix = "fnc",
    body = {
      "@classmethod",
      "def ${1:function}(cls${4:, $5})${2: -> ${3:None}:}",
      "    $0"
    },
  },
  {
    desc = "import",
    prefix = "im",
    body = "import $0",
  },
  {
    desc = "import",
    prefix = "fim",
    body = "from $1 import $0",
  },
  {
    desc = "insert breakpoint",
    prefix = "b",
    body = "breakpoint()",
  },
  {
    desc = "insert dunder",
    prefix = "_",
    body = "__${0}__",
  },
  {
    desc = "insert triple single quotes",
    prefix = "3s",
    body = "'''$0'''",
  },
  {
    desc = "insert triple single quotes",
    prefix = "3d",
    body = "\"\"\"$0\"\"\"",
  },
  {
    desc = "comprehension",
    prefix = "c",
    body = "${3:${2:item}} for $2 in ${1:items}$0"
  }
}
