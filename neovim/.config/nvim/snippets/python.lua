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
      "\t$0",
    },
  },

  ["wrap in while 'while' loop"] = {
    prefix = "wwh",
    body = {
      "while ${1:True}:",
      "\t${0:$DEDENTED_SELECTED_TEXT}",
    },
  },

  ["'with' statement"] = {
    prefix = "wi",
    body = {
      "with ${1:context}:",
      "\t$0",
    },
  },

  ["wrap in 'with' statement"] = {
    prefix = "wwi",
    body = {
      "with ${1:context}:",
      "\t${0:$DEDENTED_SELECTED_TEXT}",
    },
  },

  ["'if' statement"] = {
    prefix = "if",
    body = {
      "if ${1:condition}:",
      "\t$0",
    },
  },

  ["wrap in 'if' statement"] = {
    prefix = "wif",
    body = {
      "if ${1:condition}:",
      "\t${0:$DEDENTED_SELECTED_TEXT}",
    },
  },

  ["'for' statement"] = {
    prefix = "fo",
    body = {
      "for ${1:item} in {$2:items}:",
      "\t$0",
    },
  },

  ["'def' statement"] = {
    prefix = "de",
    body = {
      "def ${1:func}(${2:args})$3:",
      "\t$0",
    },
  },

  ["'def' method statement"] = {
    prefix = "dem",
    body = {
      "def ${1:func}(self, ${2:args})$3:",
      "\t$0",
    },
  },

  ["Breakpoint"] = {
    prefix = "b",
    body = {
      "# FIXME($GIT_USERNAME): Remove this breakpoint",
      "breakpoint()",
    },
  },

  ["Conditional breakpoint"] = {
    prefix = "bc",
    body = {
      "if $1:",
      "\tbreakpoint()",
    },
  },

  ["Debug statement"] = {
    prefix = "bd",
    body = {
      "# FIXME($GIT_USERNAME): Remove this breakpoint",
      "try:",
      "\t${0:$DEDENTED_SELECTED_TEXT}",
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
      "\t${0:$DEDENTED_SELECTED_TEXT}",
      "except Exception as exc:",
      "\tpass",
    },
  },

  ["'try/finally' clause"] = {
    prefix = "tf",
    body = {
      "try:",
      "\t${0:$DEDENTED_SELECTED_TEXT}",
      "finally:",
      "\tpass",
    },
  },

  ["Magic method"] = {
    prefix = "__",
    body = "__$0__",
  },

  ["Multiline string with double quotes"] = {
    prefix = "#d",
    body = '"""$0"""',
  },

  ["Multiline string with single quotes"] = {
    prefix = "#s",
    body = "'''$0'''",
  },

  ["List comprehension"] = {
    prefix = "cl",
    body = "[${1:item} for $1 in ${2:${1}s}]",
  },

  ["List comprehension with filter"] = {
    prefix = "clf",
    body = "[${1:item} for $1 in ${2:${1}s} if ${3:condition}]",
  },

  ["Set comprehension"] = {
    prefix = "cs",
    body = "{${1:item} for $1 in ${2:${1}s}}",
  },

  ["Set comprehension with filter"] = {
    prefix = "csf",
    body = "{${1:item} for $1 in ${2:${1}s} if ${3:condition}}",
  },

  ["Dict comprehension"] = {
    prefix = "cd",
    body = "{${1:key}: ${2:value} for $1, $2 in ${3:items}}",
  },

  ["Dict comprehension with filter"] = {
    prefix = "cdf",
    body = "{${1:key}: ${2:value} for $1, $2 in ${3:items} if ${4:condition}}",
  },
}
