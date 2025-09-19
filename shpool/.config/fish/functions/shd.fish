#!/usr/bin/env fish

function shd -d "shpool detach"
  set current_session (set -q SHPOOL_SESSION_NAME || echo "")

  if test -z "$current_session"
    return
  end

  if type -q kitten
    kitten notify --icon info --app-name shpool \
      "Shell Pool" \
      "Attached from '$current_session' session"
  end

  shpool detach
end
