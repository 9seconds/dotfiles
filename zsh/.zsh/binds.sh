#!/usr/bin/env zsh

bindkey "^R" history-incremental-pattern-search-backward
bindkey "^S" history-incremental-pattern-search-forward

zle -N edit-command-line
bindkey "^E" edit-command-line
