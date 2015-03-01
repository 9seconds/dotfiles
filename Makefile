###############################################################################
# MAKEFILE TO BOOTSTRAP MY STUFF
###############################################################################


#------------------------------------------------------------------------------
# Variables
#------------------------------------------------------------------------------

ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
ZSH_DIR := $(ROOT_DIR)/zsh

APT_GET := sudo apt-get
PACKAGE_INSTALL := $(APT_GET) -qq install -y
PIP_OPTS := --user --upgrade
PIP6_OPTS := $(PIP_OPTS) --no-cache-dir --disable-pip-version-check



#------------------------------------------------------------------------------
# Global targets
#------------------------------------------------------------------------------

all: bootstrap
bootstrap: vim git tmux zsh taskwarrior python
packages: vim_package tmux_package git_package taskwarrior_package \
	zsh_package pip_list
configs: update_submodules vim_config tmux_config git_config \
	taskwarrior_config zsh_config

update_submodules: git_package
	git submodule update --init --recursive && \
	git submodule foreach --recursive git clean -xfd && \
	git submodule foreach --recursive git reset --hard



#------------------------------------------------------------------------------
# ZSH targets
#------------------------------------------------------------------------------

zsh: zsh_package zsh_config

zsh_package:
	$(PACKAGE_INSTALL) zsh

zsh_config: clean_zsh_config update_submodules zsh_submodule_symlinks
	ln -s "$(ZSH_DIR)" "$(HOME)/.zsh" && \
	ln -s "$(HOME)/.zsh/rc.sh" "$(HOME)/.zshrc" && \
	ln -s "$(HOME)/.zsh/env.sh" "$(HOME)/.zshenv"

clean_zsh_config:
	rm -f "$(HOME)/.zsh" "$(HOME)/.zshrc" "$(HOME)/.zshenv"

zsh_submodule_symlinks: update_submodules
	ln -s "$(ZSH_DIR)/9seconds-zsh-theme/9seconds.zsh-theme" "$(ZSH_DIR)/oh-my-zsh/themes/"


#------------------------------------------------------------------------------
# GIT targets
#------------------------------------------------------------------------------

git: git_package git_config

git_package:
	$(PACKAGE_INSTALL) git

git_config: clean_git_config
	ln -s "$(ROOT_DIR)/gitconfig" "$(HOME)/.gitconfig" && \
	ln -s "$(ROOT_DIR)/gitutils" "$(HOME)/.gitutils"

clean_git_config:
	rm -f "$(HOME)/.gitconfig" "$(HOME)/.gitutils"



#------------------------------------------------------------------------------
# VIM targets
#------------------------------------------------------------------------------

vim: vim_package vim_config

vim_package:
	$(PACKAGE_INSTALL) vim

vim_config: clean_vim_config vim_neobundle
	ln -s "$(ROOT_DIR)/vimrc" "$(HOME)/.vimrc"

clean_vim_config:
	rm -f "$(HOME)/.vimrc"

vim_neobundle:
	rm -rf "$(HOME)/.vim/bundle/neobundle.vim" && \
	curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh

#------------------------------------------------------------------------------
# TMUX targets
#------------------------------------------------------------------------------

tmux: tmux_package tmux_config

tmux_package:
	$(PACKAGE_INSTALL) tmux

tmux_config: clean_tmux_config
	ln -s "$(ROOT_DIR)/tmux.conf" "$(HOME)/.tmux.conf"

clean_tmux_config:
	rm -f "$(HOME)/.tmux.conf"

#------------------------------------------------------------------------------
# TaskWarrior targets
#------------------------------------------------------------------------------

taskwarrior: taskwarrior_package taskwarrior_config

taskwarrior_package:
	$(PACKAGE_INSTALL) taskwarrior

taskwarrior_config: clean_taskwarrior_config
	ln -s "$(ROOT_DIR)/taskrc" "$(HOME)/.taskrc"

clean_taskwarrior_config:
	rm -f "$(HOME)/.taskrc"

#------------------------------------------------------------------------------
# Python targets
#------------------------------------------------------------------------------

python: pip_package pip_bootstrap pip_list

pip_package:
	$(PACKAGE_INSTALL) python-pip

pip_bootstrap: pip_package
	pip install $(PIP_OPTS) pip

pip_list: pip_bootstrap zsh
	zsh -i -c "pipup"
