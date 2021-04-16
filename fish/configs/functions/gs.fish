#!/usr/bin/env fish

function gs -d 'git status' -w git
  command git s $argv
end
