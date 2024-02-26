#!/usr/bin/env fish

set -gx -a --path _ZO_EXCLUDE_DIRS $HOME $HOME/.cache /tmp /var/tmp

if command -q zoxide then
  zoxide init fish | source
end
