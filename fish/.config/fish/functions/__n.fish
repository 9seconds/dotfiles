#!/usr/bin/env fish

function __n -d 'Run a command and notify about elapsed time'
  set cmd (commandline -b)

  set start (date +%s)
  echo
  commandline -r ''
  time eval $cmd
  commandline -f repaint
  set end (date +%s)
  set elapsed (math $end - $start)

  _notify -a "Done in $elapsed seconds." $cmd
end
