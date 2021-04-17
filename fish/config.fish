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

# CONFIG_DIR is a path to custom configuration files.
set -l CONFIG_DIR $__fish_config_dir/config.fish.d
not test -d $CONFIG_DIR; and mkdir -p $CONFIG_DIR

# CONFIG_FUNCTIONS_DIR is a path to custom autoloading functions.
# It should be present in CONFIG_DIR because usually CONFIG_DIR
# is a symlink from dotfiles.
set -l CONFIG_FUNCTIONS_DIR $CONFIG_DIR/functions
not contains $CONFIG_FUNCTIONS_DIR $fish_function_path; and set -gp fish_function_path $CONFIG_FUNCTIONS_DIR

for filename in $CONFIG_DIR/*.fish
  source $filename
end

test -e $HOME/.local-config.fish; and source $HOME/.local-config.fish
