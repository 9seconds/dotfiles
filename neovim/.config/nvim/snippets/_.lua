return {
  -- _year -> 2025
  ["Insert current year"] = {
    prefix = "_year",
    body = "$CURRENT_YEAR",
  },

  -- _date -> 2025-01-03
  ["Insert current date"] = {
    prefix = "_date",
    body = "$CURRENT_YEAR-$CURRENT_MONTH-$CURRENT_DATE",
  },

  -- _time -> 08:26
  ["Insert current time"] = {
    prefix = "_time",
    body = "$CURRENT_HOUR:$CURRENT_MINUTE",
  },

  -- _times -> 08:26:36
  ["Insert current time with seconds"] = {
    prefix = "_times",
    body = "$CURRENT_HOUR:$CURRENT_MINUTE:$CURRENT_SECOND",
  },

  -- _unix -> 1735892819
  ["Insert UNIX timestamp"] = {
    prefix = "_unix",
    body = "$CURRENT_SECONDS_UNIX",
  },

  -- _rnd -> 281205
  ["Insert random number"] = {
    prefix = "_rnd",
    body = "$RANDOM",
  },

  -- _rndh -> f6ad74
  ["Insert randon HEX number"] = {
    prefix = "_rndh",
    body = "$RANDOM_HEX",
  },

  -- _uuid -> ececde38-86a4-43e7-9a82-a6b36719a906
  ["Insert random UUID"] = {
    prefix = "_uuid",
    body = "$UUID",
  },

  -- #T -> -- TODO(9seconds): Comment
  ["TODO comment"] = {
    prefix = "#T",
    body = "$LINE_COMMENT TODO($GIT_USERNAME): ",
  },

  -- #F -> -- FIXME(9seconds): Comment
  ["FIXME comment"] = {
    prefix = "#F",
    body = "$LINE_COMMENT FIXME($GIT_USERNAME): ",
  },

  -- #! -> #!/usr/bin/env hello
  ["Shebang comment"] = {
    prefix = "#!",
    body = "#!/${1:usr/bin/env }$0",
  },
}
