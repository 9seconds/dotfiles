#!/usr/bin/env fish

function mr -d 'Run mise tasks' -w 'mise tasks run'
  mise tasks run $argv
end
