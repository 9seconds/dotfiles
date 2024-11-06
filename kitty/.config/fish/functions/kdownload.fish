#!/usr/bin/env fish

function kdownload -d 'download files using kitty'
  if test (count $argv) -lt 2
    echo "Usage: kdownload <paths on this machine> <main computer path>"
    return 1
  end

  set config_dir ~/.config
  if set -q XDG_CONFIG_DIR
    set config_dir $XDG_CONFIG_DIR
  end

  set home (string escape --style=regex (realpath ~))
  set argv[-1] (string replace -r "^$home" '~' $argv[-1])

  kitten transfer --confirm-paths $argv
end
