#!/usr/bin/env fish

function ssh -w ssh -d "ssh wrapper that is aware of kitten"
  set local_socket (string replace -r "^.*://" "" $KITTY_LISTEN_ON)
  set opts -R $local_socket:$local_socket -o SendEnv=KITTY_LISTEN_ON

  if not set -q SSH_CONNECTION; and command -v kitten >/dev/null
    kitten ssh $opts $argv
  else
    command ssh $opts $argv
  end
end
