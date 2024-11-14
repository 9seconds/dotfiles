#!/usr/bin/env fish

function ssh-init -d "initialize ssh configuration"
  if test (count $argv) -gt 2
    echo "Error: ssh-init accepts at most 2 arguments" >&2
    return 1
  else if test (count $argv) -eq 0
    echo "Error: ssh-init accepts at least 1 argument" >&2
    return 1
  end

  set host $argv[1]
  set port 22

  if test (count $argv) -eq 2
    set port $argv[2]
  end

  ssh-copy-id -p $port $host 2>/dev/null
  infocmp -a xterm-kitty | ssh -p $port $host -- tic -x -o \~/.terminfo /dev/stdin 2>/dev/null
end
