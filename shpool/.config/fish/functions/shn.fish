#!/usr/bin/env fish

function shn -d "new shell pool session"
  if test (count $argv) -gt 0
    set session_name $argv[1]
  else
    set session_name (shuf -n 1 /usr/share/dict/words)
  end

  shpool attach $session_name
end
