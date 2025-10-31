#!/usr/bin/env fish

if not set -q KITTY_INSTALLATION_DIR
  set    order /Applications/kitty.app/Contents/Resources/kitty
  set -a order /usr/lib/kitty
  set -a order ~/.local/share/kitty-ssh-kitten

  for candidate in $order
    if test -d $candidate
      set -g KITTY_INSTALLATION_DIR $candidate
      break
    end
  end
end

if set -q KITTY_INSTALLATION_DIR
  set --global KITTY_SHELL_INTEGRATION enabled
  source "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_conf.d/kitty-shell-integration.fish"
  set --prepend fish_complete_path "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_completions.d"
  fish_add_path --path "$KITTY_INSTALLATION_DIR/kitty/bin"
end
