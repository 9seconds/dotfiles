#!/usr/bin/env fish
# vim: set sw=2 sts=2 ts=2

# Description

set this_script_path $(path resolve $(status --current-filename))
set this_script_name $(path basename $this_script_path)

function show_help
  echo "Usage: $this_script_name [-h/--help] [-d/--debug] ARG"
  echo
  echo 'New great script'
  echo
  echo 'Options:'
  echo '  -h, --help    Show this help message and exit'
  echo '  -d, --debug   Run in debug mode'
end

argparse --min-args=1 --max-args=1 'h/help&' 'd/debug&' -- $argv
or begin
  show_help
  return 1
end

if set -q _flag_debug
  set fish_trace 1
end
if set -q _flag_help
  show_help
  return 0
end

exec echo 1
