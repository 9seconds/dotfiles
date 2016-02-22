# This is a make file which installs vim with my config onto remote host

# -----------------------------------------------------------------------------

CURL = curl --create-dirs -sfLo

VIMRC = $(HOME)/.vimrc
VIMDIR = $(HOME)/.vim
VIMDIR_AUTO = $(VIMDIR)/autoload
VIMDIR_PLUG = $(VIMDIR)/plugged

URL_VIMPLUG = https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
URL_VIMRC = https://raw.githubusercontent.com/9seconds/dotfiles/master/vimrc


# -----------------------------------------------------------------------------

all: init vimplug config plugins

vimplug: init
	@$(CURL) $(VIMDIR_AUTO)/plug.vim $(URL_VIMPLUG)

config: init
	@$(CURL) $(VIMRC) $(URL_VIMRC)

plugins: config
	@cd $(VIMDIR_PLUG) && grep -E "^[ \t\]*Plug\s+" $(VIMRC) \
		| cut -d"'" -f2 - \
		| sed 's?\(.*\)?https://github.com/\1.git?' \
		| xargs -n 1 -P 4 git clone --recursive --depth 1 --quiet

init: clean
	@mkdir -p $(VIMDIR_AUTO)
	@mkdir -p $(VIMDIR_PLUG)

clean:
	@rm -rf $(VIMDIR)
	@rm -f $(VIMRC)