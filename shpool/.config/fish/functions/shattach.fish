#!/usr/bin/env fish

function shattach -d "attach to shpool session"
  set name $argv[1]
  if test (count $argv) != 1
    printf "Usage: shattach <session>\n" 1>&2
    exit 1
  end

  if printenv | grep -q KITTY
    set userdir /run/user/(id -u)/shpool/sessions/$argv[1]
    mkdir -p $userdir >/dev/null
    printenv | grep KITTY > $userdir/kitty.env
  end

  shpool attach -f $argv[1]
end
