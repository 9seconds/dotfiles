return {
  {
  prefix = "im",
  body = "import $0",
  desc = "Import statement"
  },
  {
    prefix = "fr",
    body = "from ${1:.} import ${2:*}",
    desc = "From/import statement"
  },

  {
    prefix = "wh",
    body = {
      "while ${1:True}:",
      "\t${0:$TM_SELECTED_TEXT}"
    },
    desc = "While loop",
  },

  {
    prefix = "wi",
    body = {
      "with ${1:context}${2: as ${3:_$1}}:",
      "\t${0:$TM_SELECTED_TEXT}"
    },
    desc = "with statement",
  },
  {
    prefix = "awi",
    body = {
      "async with ${1:context}${2: as ${3:_$1}}:",
      "\t${0:$TM_SELECTED_TEXT}"
    },
    desc = "async with statement",
  },

  {
    prefix = "fo",
    body = {
      "for ${1:item} in {$2:items}:",
      "\t${0:TM_SELECTED_TEXT}"
    },
    desc = "for statement"
  },
  {
    prefix = "afo",
    body = {
      "async for ${1:item} in {$2:items}:",
      "\t${0:TM_SELECTED_TEXT}"
    },
    desc = "async for statement"
  },

  {
    prefix = "de",
    body = {
      "def ${1:func}(${2:self, ${3:args}})${4: -> ${5:None}}:",
      "\t${0:return None}"
    },
    desc = "Function definition"
  },
  {
    prefix = "ade",
    body = {
      "async def ${1:func}(${2:self, ${3:args}})${4: -> ${5:None}}:",
      "\t${0:return None}"
    },
    desc = "Function definition"
  },

  {
    prefix = "tex",
    body = {
      "try:"      ,
      "${1:$TM_SELECTED_TEXT}",
      "except${2: Exception${3: as ${4:exc}}}:",
      "\t${0:pass}"
    },
    desc = "try/except clause"
  },
  {
    prefix = "tfi",
    body = {
      "try:"      ,
      "${1:$TM_SELECTED_TEXT}",
      "finally:",
      "\t${0:pass}"
    },
    desc = "try/finally clause"
  },
  {
    prefix = "texfi",
    body = {
      "try:"      ,
      "${1:$TM_SELECTED_TEXT}",
      "except${2: Exception${3: as ${4:exc}}}:",
      "\t${2:pass}",
      "finally:",
      "\t${0:pass}"
    },
    desc = "try/except/finally clause"
  },
  {
    prefix = "tbr",
    body = {
      "try",
      "${1:$TM_SELECTED_TEXT}",
      "except:",
      "\timport sys",
      "\timport traceback",
      "",
      "\ttyp_, val_, tb_ = sys.exc_info()",
      "\ttbf_ = traceback.format_tb(tb_)",
      "\tbreakpoint()",
      "\tassert True"
    },
    desc = "Conditional breakpoint"
  },

  {
    prefix = "br",
    body = "breakpoint()",
    desc = "Set a breakpoint"
  },
  {
    prefix = "brc",
    body = {
      "if ${1:condition}:",
      "\tbreakpoint()"
    },
    desc = "Conditional breakpoint"
  },
}
