#!/usr/bin/env fish

function shn -d "new shell pool session"
  shd

  set session_name $argv[1]

  if type -q kitten
    kitten notify --icon info --app-name shpool \
      "Shell Pool" \
      "Attached to '$session_name' session"
  end

  shpool attach $session_name
end
