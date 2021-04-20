#!/usr/bin/env fish
#
# This is a configuration file for Fish shell. This is
# configuration file used by Sergey Arkhipov. There are many good
# configuration files available everywhere but here is mine.
#
# A main idea behind this configuration is to be deployed
# from dotfiles. In order to have autoloading and so on,
# we do not use default ~/.config/fish/functions paths
# and so on because they are populated by other means. Instead
# I use an alternative structure:
#
#     $XDG_CONFIG_HOME/fish/config.fish.d/*.fish for snippets
#     $XDG_CONFIG_HOME/fish/config.fish.d/functions for functions

# CONFIG_DIR is a path to a dotfiles configuration files.
set -l DOTFILES_CONFIG_DIR $__fish_config_dir/config.fish.d
not contains $DOTFILES_CONFIG_DIR/functions $fish_function_path; and set -gp fish_function_path $DOTFILES_CONFIG_DIR/functions
not contains $DOTFILES_CONFIG_DIR/completions $fish_complete_path; and set -gp fish_complete_path $DOTFILES_CONFIG_DIR/completions

for filename in $DOTFILES_CONFIG_DIR/*.fish
  source $filename
end

# LOCAL_CONFIG_DIR is a directory with fish configuration but for a local
# machine.
set -l LOCAL_CONFIG_DIR $HOME/.local-fish
test -r $LOCAL_CONFIG_DIR/config.fish; and source $LOCAL_CONFIG_DIR/config.fish
if test -d $LOCAL_CONFIG_DIR/functions
  and not contains $LOCAL_CONFIG_DIR/functions $fish_function_path
  set -gp fish_function_path $LOCAL_CONFIG_DIR/functions
end
if test -d $LOCAL_CONFIG_DIR/completions
  and not contains $LOCAL_CONFIG_DIR/completions $fish_complete_path
  set -gp fish_complete_path $LOCAL_CONFIG_DIR/completions
end
