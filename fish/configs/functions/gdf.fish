#!/usr/bin/env fish

function gdf -d 'git diff' -w git
  command git df $argv
end
