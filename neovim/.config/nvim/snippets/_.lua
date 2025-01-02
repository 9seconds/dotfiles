local username = vim.trim(vim.fn.system("git config user.name") or "")

return {
  -- date times
  {
    prefix = "_year",
    body = "$CURRENT_YEAR",
    desc = "Insert current year",
  },
  {
    prefix = "_date",
    body = "$CURRENT_YEAR-$CURRENT_MONTH-$CURRENT_DATE",
    desc = "Insert current date",
  },
  {
    prefix = "_time",
    body = "$CURRENT_HOUR:$CURRENT_MINUTE",
    desc = "Insert current time",
  },
  {
    prefix = "_times",
    body = "$CURRENT_HOUR:$CURRENT_MINUTE:$CURRENT_SECOND",
    desc = "Insert current time",
  },
  {
    prefix = "_unix",
    body = "$CURRENT_SECONDS_UNIX",
    desc = "Insert UNIX timestamp",
  },
  {
    prefix = "_rnd",
    body = "$RANDOM",
    desc = "Insert random number",
  },
  {
    prefix = "_rndh",
    body = "$RANDOM_HEX",
    desc = "Insert random HEX number",
  },
  {
    prefix = "_uuid",
    body = "$UUID",
    desc = "Insert random UUID",
  },

  -- todo comments
  {
    prefix = "#T",
    body = string.format("$LINE_COMMENT TODO(%s): $0", username),
    desc = "TODO comment",
  },
  {
    prefix = "#F",
    body = string.format("$LINE_COMMENT FIXME(%s): $0", username),
    desc = "FIXME comment",
  },

  -- misc stuff
  {
    prefix = "#!",
    body = "#!${1:/usr/bin/env $2}",
    desc = "Shebang",
  },
}
