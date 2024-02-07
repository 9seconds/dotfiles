#!/usr/bin/env fish

# https://iterm2.com/3.2/documentation-escape-codes.html
function set_user_var -d 'Set user var'
  set -f fmt "\033]1337;SetUserVar=%s=%s\007"

  if set -q TMUX
    set fmt "\033Ptmux;\033\033]1337;SetUserVar=%s=%s\007\033\\"
  end

  printf $fmt $argv[1] (printf $argv[2] | base64 -w 0)
end
