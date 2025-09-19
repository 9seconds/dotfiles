#!/usr/bin/env fish

function sha -d "shpool attach"
  set session_name (shpool list | string match -r -g '(\S+).+\bdisconnected$' | 9fzf --sort --with-nth 1 --accept-nth 1 --exit-0 --select-1)
  set current_session (set -q SHPOOL_SESSION_NAME || echo "")

  if test -z "$session_name" || test "$session_name" = "$current_session"
    return
  end

  if test -n "$current_session"
    shpool detach
  end

  if type -q kitten
    kitten notify --icon info --app-name shpool \
      "Shell Pool" \
      "Attached to '$session_name' session"
  end

  shpool attach $session_name
end
