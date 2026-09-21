return {
  -- N -> 9seconds
  {
    desc = "Insert Git username",
    prefix = "N",
    body = "$GIT_USERNAME",
  },
  -- M -> nineseconds@...com
  {
    desc = "Insert Git user email",
    prefix = "M",
    body = "$GIT_EMAIL",
  },

  -- D -> 2026
  {
    desc = "Insert current year",
    prefix = "D",
    body = "$CURRENT_YEAR",
  },
  -- DD -> 2026-09-10
  {
    desc = "Insert current date",
    prefix = "DD",
    body = "$CURRENT_YEAR-$CURRENT_MONTH-$CURRENT_DATE",
  },
  -- DDD -> 2026-09-21T11:18:12
  {
    desc = "Insert current date as IOS8601 timestamp",
    prefix = "DDD",
    body = "$CURRENT_YEAR-$CURRENT_MONTH-${CURRENT_DATE}T$CURRENT_HOUR:$CURRENT_MINUTE:$CURRENT_SECOND",
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
  -- SS -> 1789033239
  {
    desc = "Insert current unix timestamp",
    prefix = "SS",
    body = "$CURRENT_SECONDS_UNIX",
  },

  -- R -> 791011
  {
    desc = "Insert random number",
    prefix = "R",
    body = "$RANDOM",
  },
  -- RR -> c2fbee
  {
    desc = "Insert random hex number",
    prefix = "RR",
    body = "$RANDOM_HEX",
  },
  -- RRR -> 768a1f25-ff6d-45ba-8370-a4fb1e23a9fc
  {
    desc = "Insert random uuid",
    prefix = "RRR",
    body = "$UUID",
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
