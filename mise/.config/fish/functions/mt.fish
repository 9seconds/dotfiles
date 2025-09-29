#!/usr/bin/env fish

function mt -w 'mise tasks' -d 'mise tasks'
  if test (count $argv) -eq 0
    mise tasks
  else
    mise tasks run $argv
  end
end
