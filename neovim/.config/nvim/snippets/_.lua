return {
  -- Y -> 2026
  {
    desc = "Insert current year",
    prefix = "Y",
    body = "$CURRENT_YEAR",
  },
  -- D -> 2026-09-10
  {
    desc = "Insert current date",
    prefix = "D",
    body = "$CURRENT_YEAR-$CURRENT_MONTH-$CURRENT_DATE",
  },
  -- T -> 09:39
  {
    desc = "Insert current time",
    prefix = "T",
    body = "$CURRENT_HOUR:$CURRENT_MINUTE",
  },
  -- S -> 09:39:35
  {
    desc = "Insert current time with seconds",
    prefix = "S",
    body = "$CURRENT_HOUR:$CURRENT_MINUTE:$CURRENT_SECOND",
  },
  -- U -> 1789033239
  {
    desc = "Insert current unix timestamp",
    prefix = "U",
    body = "$CURRENT_SECONDS_UNIX",
  },
  -- R -> 791011
  {
    desc = "Insert random number",
    prefix = "R",
    body = "$RANDOM",
  },
  -- H -> c2fbee
  {
    desc = "Insert random hex number",
    prefix = "H",
    body = "$RANDOM_HEX",
  },
  -- #T -> -- TODO(9seconds): Comment
  {
    desc = "TODO comment",
    prefix = "#T",
    body = "$LINE_COMMENT TODO($GIT_USERNAME): ",
  },
  -- #F -> -- FIXME(9seconds): Comment
  {
    desc = "FIXME comment",
    prefix = "#F",
    body = "$LINE_COMMENT FIXME($GIT_USERNAME): ",
  },
  -- #! -> #!/usr/bin/env hello
  {
    desc = "Shebang",
    prefix = "#!",
    body = "#!/${1:usr/bin/env }$0",
  },
}
