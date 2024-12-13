#!/usr/bin/env fish

function ssh -w ssh -d "ssh wrapper that is aware of kitten"
  set local_socket (string replace -r "^.*://" "" $KITTY_LISTEN_ON)
  set cmd ssh -R $local_socket:$local_socket -o SendEnv=KITTY_LISTEN_ON

  if not set -q SSH_CONNECTION
    set cmd kitten $cmd
  end

  $cmd $argv
end
