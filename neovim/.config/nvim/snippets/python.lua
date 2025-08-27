return {
  ["'async' keyword"] = {
    prefix = "a",
    body = "async $0",
  },

  ["'while' loop"] = {
    prefix = "wh",
    body = {
      "while ${1:True}:",
      "\t$0",
    },
  },

  ["wrap in while 'while' loop"] = {
    prefix = "wh_",
    body = {
      "while ${1:True}:",
      "\t$TM_SELECTED_TEXT",
    },
  },

  ["'with' statement"] = {
    prefix = "with",
    body = {
      "with ${1:context}:",
      "\t$0",
    },
  },

  ["wrap in 'with' statement"] = {
    prefix = "with_",
    body = {
      "with ${1:context}:",
      "\t$TM_SELECTED_TEXT",
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
    prefix = "if_",
    body = {
      "if ${1:condition}:",
      "\t$TM_SELECTED_TEXT",
    },
  },

  ["'for' statement"] = {
    prefix = "for",
    body = {
      "for ${1:item} in {$2:items}:",
      "\t$0",
    },
  },

  ["wrap in 'for' statement"] = {
    prefix = "for_",
    body = {
      "for ${1:item} in {$2:items}:",
      "\t$TM_SELECTED_TEXT",
    },
  },

  ["'def' statement"] = {
    prefix = "def",
    body = {
      "def ${1:func}(${2:args}):",
      "\t$0",
    },
  },

  ["'def' method statement"] = {
    prefix = "defs",
    body = {
      "def ${1:func}(${2:self}, ${3:args}):",
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
      "\t${0:$TM_SELECTED_TEXT}",
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
      "\t$0",
      "except ${1:Exception} as exc:",
      "\tpass",
    },
  },

  ["wrap in 'try/except' clause"] = {
    prefix = "te_",
    body = {
      "try:",
      "\t$TM_SELECTED_TEXT",
      "except ${1:Exception} as exc:",
      "\tpass",
    },
  },

  ["'try/finally' clause"] = {
    prefix = "tf",
    body = {
      "try:",
      "\t$0",
      "finally:",
      "\tpass",
    },
  },

  ["wrap in 'try/finally' clause"] = {
    prefix = "tf",
    body = {
      "try:",
      "\t$TM_SELECTED_TEXT",
      "finally:",
      "\t$0",
    },
  },

  ["Magic method"] = {
    prefix = "__",
    body = "__$0__",
  },

  ["Multiline string with double quotes"] = {
    prefix = "3\"",
    body = '"""$0"""',
  },

  ["Multiline string with single quotes"] = {
    prefix = "3'",
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
