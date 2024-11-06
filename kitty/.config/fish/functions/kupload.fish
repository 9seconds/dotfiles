#!/usr/bin/env fish

function kupload -d 'upload files using kitty'
  if test (count $argv) -lt 2
    echo "Usage: kupload <main computer path> <paths on this machine>"
    return 1
  end

  set config_dir ~/.config
  if set -q XDG_CONFIG_DIR
    set config_dir $XDG_CONFIG_DIR
  end

  set home (string escape --style=regex (realpath ~))
  set argv[1] (string replace -r "^$home" '~' $argv[1])

  kitten transfer --direction=upload --confirm-paths $argv
end
