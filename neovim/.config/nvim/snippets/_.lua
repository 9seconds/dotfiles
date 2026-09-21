local TIME = {
  -- N -> 9seconds
  ["git username"] = {
    prefix = "N",
    body = "$GIT_USERNAME",
  },
  -- M -> nineseconds@...com
  ["git user email"] = {
    prefix = "M",
    body = "$GIT_EMAIL",
  },

  -- D -> 2026
  ["current year"] = {
    prefix = "D",
    body = "$CURRENT_YEAR",
  },
  -- DD -> 2026-09-10
  ["current date"] = {
    prefix = "DD",
    body = "$CURRENT_YEAR-$CURRENT_MONTH-$CURRENT_DATE",
  },
  -- DDD -> 2026-09-21T11:18:12
  ["iso8601 timestamp"] = {
    prefix = "DDD",
    body = "$CURRENT_YEAR-$CURRENT_MONTH-${CURRENT_DATE}T$CURRENT_HOUR:$CURRENT_MINUTE:$CURRENT_SECOND",
  },
  -- T -> 09:39
  ["current time"] = {
    prefix = "T",
    body = "$CURRENT_HOUR:$CURRENT_MINUTE",
  },
  -- TT -> 09:39:35
  ["current time with seconds"] = {
    prefix = "TT",
    body = "$CURRENT_HOUR:$CURRENT_MINUTE:$CURRENT_SECOND",
  },
  -- TTT -> 1789033239
  ["current unix timestamp"] = {
    prefix = "TTT",
    body = "$CURRENT_SECONDS_UNIX",
  },
}

-------------------------------------------------------------------------------

local RANDOM = {
  -- R -> 791011
  ["random number"] = {
    prefix = "R",
    body = "$RANDOM",
  },
  -- RR -> c2fbee
  ["random hex number"] = {
    prefix = "RR",
    body = "$RANDOM_HEX",
  },
  -- RRR -> 768a1f25-ff6d-45ba-8370-a4fb1e23a9fc
  ["random uuid"] = {
    prefix = "RRR",
    body = "$UUID",
  },
}

-------------------------------------------------------------------------------

local COMMENT = {
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
  ["shebang"] = {
    prefix = "#!",
    body = "#!/${1:usr/bin/env }$0",
  },
}

-------------------------------------------------------------------------------

local RV = {}

RV = vim.tbl_extend("error", RV, TIME)
RV = vim.tbl_extend("error", RV, RANDOM)
RV = vim.tbl_extend("error", RV, COMMENT)

return RV
