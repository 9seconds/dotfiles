#!/usr/bin/env fish

function mkcd -d 'Create a directory and step into that'
  if test (count $argv) -ne 1
    echo "Usage: mkcd <path>" 1>&2
    return 1
  end
  mkdir -pv $argv[1]
  cd $argv[1]
end
