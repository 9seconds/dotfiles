#!/usr/bin/env fish

if command -q nvim
  set editor nvim
else
  set editor vim
end

function v -d 'vim' -w vim -V editor
  command $editor $argv
end
