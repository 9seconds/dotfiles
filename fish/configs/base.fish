#!/usr/bin/env fish
#
# This file contains base things and environment variables

set -U fish_greeting

not test -f $HOME/.hushlogin; touch $HOME/.hushlogin
