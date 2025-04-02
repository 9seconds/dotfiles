#!/usr/bin/env fish

function mtr -d 'Run mise tasks' -w 'mise tasks runs'
  mise tasks run $argv
end
