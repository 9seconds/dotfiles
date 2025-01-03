return {
  ["'import' statement"] = {
    prefix = "im",
    body = "import $0",
  },

  ["'from/import' statement"] = {
    prefix = "fr",
    body = "from ${1:.} import ${0:*}",
  },

  ["'async' keyword"] = {
    prefix = "a",
    body = "async $0",
  },

  ["Type definition"] = {
    prefix = "t",
    body = "$1: ${2:type}",
  },

  ["'while' loop"] = {
    prefix = "wh",
    body = {
      "while ${1:True}:",
      "\t${0:$NS_SELECTED_TEXT}",
    },
  },

  ["'with' statement"] = {
    prefix = "wi",
    body = {
      "with ${1:context}${2: as ${3:_$1}}:",
      "\t${0:$NS_SELECTED_TEXT}",
    },
  },

  ["'for' statement"] = {
    prefix = "fo",
    body = {
      "for ${1:item} in {$2:items}:",
      "\t${0:$NS_SELECTED_TEXT}",
    },
  },

  ["'def' statement"] = {
    prefix = "de",
    body = {
      "def ${1:func}(${2:args}):",
      "\t$0",
    },
  },

  ["'def' method statement"] = {
    prefix = "dem",
    body = {
      "def ${1:func}(self, ${2:args}):",
      "\t$0",
    },
  },

  ["'def' statement with type definition"] = {
    prefix = "det",
    body = {
      "def ${1:func}(${2:args}) -> ${3:object}:",
      "\t$0",
    },
  },

  ["'def' method statement with type definition"] = {
    prefix = "demt",
    body = {
      "def ${1:func}(self, ${2:args}) -> ${3:object}:",
      "\t$0",
    },
  },

  ["Breakpoint"] = {
    prefix = "b",
    body = "breakpoint()$0",
  },

  ["Conditional breakpoint"] = {
    prefix = "bc",
    body = {
      "if $1:",
      "\tbreakpoint()$0",
    },
  },

  ["Debug statement"] = {
    prefix = "bd",
    body = {
      "try:",
      "\t${0:$NS_SELECTED_TEXT}",
      "except:",
      "\timport sys, traceback",
      "\ttyp_, val_, tb_ = sys.exc_info()",
      "\ttback_ = traceback.format_tb(tb_)",
      "\tbreakpoint()",
      "\tassert True",
    },
  },

  ["'try/except' clause"] = {
    prefix = "te",
    body = {
      "try:",
      "\t${0:$NS_SELECTED_TEXT}",
      "except${1: ${2:Exception}${3: as ${4:exc}}}:",
      "\t${5:pass}",
    },
  },

  ["'try/finally' clause"] = {
    prefix = "tf",
    body = {
      "try:",
      "\t${0:$NS_SELECTED_TEXT}",
      "finally:",
      "\t${1:pass}",
    },
  },

  ["Magic method"] = {
    prefix = "__",
    body = "__$1__",
  },

  ["Multiline string with double quotes"] = {
    prefix = "#",
    body = '"""$0"""',
  },

  ["Multiline string with single quotes"] = {
    prefix = "#",
    body = "'''$0'''",
  },
}
