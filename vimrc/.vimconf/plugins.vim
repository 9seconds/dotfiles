" Settings for Vundle

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
    Plugin 'altercation/vim-colors-solarized'
    Plugin 'bling/vim-airline'
    Plugin 'gmarik/vundle'
    Plugin 'godlygeek/tabular'
    Plugin 'hynek/vim-python-pep8-indent'
    Plugin 'jnwhiteh/vim-golang'
    Plugin 'kien/ctrlp.vim'
    Plugin 'kien/rainbow_parentheses.vim'
    Plugin 'Lokaltog/vim-easymotion'
    Plugin 'majutsushi/tagbar'
    Plugin 'scrooloose/syntastic'
    Plugin 'terryma/vim-expand-region'
    Plugin 'terryma/vim-multiple-cursors'
    Plugin 'terryma/vim-smooth-scroll'
    Plugin 'tpope/vim-commentary'
    Plugin 'tpope/vim-repeat'
    Plugin 'tpope/vim-surround'
    Plugin 'tpope/vim-unimpaired'
    Plugin 'Valloric/YouCompleteMe'
call vundle#end()
