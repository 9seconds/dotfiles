#!/usr/bin/env fish

function __n -d 'Run a command and notify about elapsed time'
  set cmd (commandline -b)

  set start (date +%s)
  commandline -f execute
  set end (date +%s)
  commandline -f repaint
  set elapsed (math $end - $start)

  _notify -a "Done in $elapsed seconds." $cmd
end
