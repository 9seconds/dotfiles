###############################################################################
# MAKEFILE TO BOOTSTRAP MY STUFF
###############################################################################


#------------------------------------------------------------------------------
# Variables
#------------------------------------------------------------------------------

ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

APT_GET := sudo apt-get
PACKAGE_INSTALL := $(APT_GET) -qq install -y


#------------------------------------------------------------------------------
# Global targets
#------------------------------------------------------------------------------

all: stow neovim vimplug

stow: install_stow
	stow -t $(HOME) -R ag git roxterm tmux zsh vim

install_stow:
	$(PACKAGE_INSTALL) stow

neovim:
	ln -sf $(HOME)/.vim $(HOME)/.config/nvim && \
	ln -sf $(HOME)/.vimrc $(HOME)/.config/nvim/init.vim

vimplug:
	make -f $(ROOT_DIR)/MakefileVim.mk vimplug
