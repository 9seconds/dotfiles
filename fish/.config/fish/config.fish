#!/usr/bin/env fish

### disable greeting prompt ---------------------------------------------------
set -U fish_greeting

### set theme -----------------------------------------------------------------
fish_config theme choose tokyonight_storm

### configure prompt ----------------------------------------------------------
set -g lucid_symbol_prompt ➜

### configure iterm2 ----------------------------------------------------------
if test -e $HOME/.iterm2_shell_integration.fish
  source $HOME/.iterm2_shell_integration.fish
end

### configure local fish ------------------------------------------------------
if test -e $HOME/.local-config.fish
  source $HOME/.local-config.fish
end

fzf_configure_bindings --directory=\cg
