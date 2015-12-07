#!/bin/sh -eu
# This installs my vim configuration onto remote host
#
# Install with curlsh:
# $ curl -sfL https://raw.githubusercontent.com/9seconds/dotfiles/master/install_vim.sh | sh

# -----------------------------------------------------------------------------------

FILE="$(mktemp)"
VIMRC_URL="https://raw.githubusercontent.com/9seconds/dotfiles/master/MakefileVim.mk"

# -----------------------------------------------------------------------------------

which curl
which git
which sed
which vim

# -----------------------------------------------------------------------------------

curl -sfLo "${FILE}" "${VIMRC_URL}" && make -f "${FILE}" all
rm -f -- "${FILE}"
