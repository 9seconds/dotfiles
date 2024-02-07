#!/usr/bin/env fish

function __set_uservars --on-event fish_prompt
  if set -q TMUX
    set_user_var IS_TMUX 1
  else
    set_user_var IS_TMUX 0
  end

  if set -q SSH_CONNECTION
    set_user_var IP (string replace -r '.+?(\S+)\s+\d+$' '$1' $SSH_CONNECTION)
    set_user_var IS_SSH 1
  else
    set_user_var IP (string replace -r '^(\S+).*' '$1' (hostname -i))
    set_user_var IS_SSH 0
  end

  set_user_var REAL_UID (id -ur)
  set_user_var REAL_USERNAME $USER
  set_user_var PWD $PWD
  set_user_var HOME $HOME
  set_user_var HOSTNAME (hostname -f)
  set_user_var CMD (command -v fish)
end

function __set_uservars_pwd --on-variable PWD
  set_user_var PWD $PWD
end

function __set_uservars_preexec --on-event fish_preexec
  set_user_var CMD (string replace -r '(\S+)\s*.+' '$1' $argv[1])
end

function __set_uservars_postexec --on-event fish_postexec
  set_user_var CMD (command -v fish)
end
