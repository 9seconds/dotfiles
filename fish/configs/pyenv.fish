#!/usr/bin/env fish
#
# This file contains everything related to pyenv.
# https://github.com/pyenv/pyenv

if not command -q pyenv
  test -d $HOME/.pyenv; and fish_add_path $HOME/.pyenv/bin; or exit
end
not command -q pyenv; and exit

pyenv init - | source
status --is-interactive; and source (pyenv virtualenv-init -| psub)

set -gx PYENV_VIRTUALENV_DISABLE_PROMPT 1
