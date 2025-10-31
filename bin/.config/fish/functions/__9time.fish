#!/usr/bin/env fish

function __9time -d 'Run a command and notify about elapsed time'
  set cmd (commandline -b)

  set start (date +%s)
  echo
  commandline -r ''
  time eval $cmd
  commandline -f repaint
  set end (date +%s)
  set elapsed (math $end - $start)

  9notify \
    $(string join -- ' ' $(string escape -- $cmd)) \
    "Done in $elapsed seconds."
end
