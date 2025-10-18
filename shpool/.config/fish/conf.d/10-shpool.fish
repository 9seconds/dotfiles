#!/usr/bin/env fish

if set -q SHPOOL_SESSION_DIR; and test -n "$SHPOOL_SESSION_DIR"
  set envfile "$SHPOOL_SESSION_DIR/kitty.env"
  if test -f $envfile
    while read -l line
      set chunks (string split -m 1 "=" $line)
      set -gx $chunks[1] $chunks[2]
    end < $envfile
  end

  if set -q SSH_KITTEN_KITTY_DIR
    fish_add_path --append --path $SSH_KITTEN_KITTY_DIR
  end
end
