#!/usr/bin/env bash
set -eu -o pipefail

command -v stow >/dev/null || (echo "Install GNU Stow first"; exit 1)

stow -R bat
stow -R --dotfiles git
stow -R python
stow -R fish
stow -R neovim
stow -R ripgrep
stow -R aria2

mkdir -p $HOME/.config/chore || true # to prevent folding at this level
stow -R chore
