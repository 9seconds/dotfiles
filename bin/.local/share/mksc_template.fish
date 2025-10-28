#!/usr/bin/env fish
# vim: set sw=2 sts=2 ts=2

# Show the contents of a script with a given name

set this_script_path $(path resolve $(status --current-filename))
set this_script_name $(path basename $this_script_path)

argparse 'h/help&' 'd/debug&' -- $argv
or return 1

if set -q _flag_debug
  set fish_trace 1
end

if set -q _flag_help
  or test (count $argv) -ne 1
  echo "Usage: $(basename $this_script_path) [-h/--help] ARG"
  echo
  echo "New great script"
  echo
  echo "Options:"
  echo "  -h, --help    Show this help message and exit"
  return 0
end

exec echo 1
