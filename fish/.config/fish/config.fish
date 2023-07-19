#!/usr/bin/env fish

### disable greeting prompt ---------------------------------------------------
set -U fish_greeting

### set theme -----------------------------------------------------------------
fish_config theme choose tokyonight_storm

### configure prompt ----------------------------------------------------------
set -g lucid_symbol_prompt ➜

### configure asdf ------------------------------------------------------------
if test -d $HOME/.asdf
  source $HOME/.asdf/asdf.fish
end

### configure iterm2 ----------------------------------------------------------
if test -e $HOME/.iterm2_shell_integration.fish
  source $HOME/.iterm2_shell_integration.fish
end
