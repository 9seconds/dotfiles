" Settings for Vundle

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
    Plugin 'gmarik/vundle'
    Plugin 'altercation/vim-colors-solarized'
    Plugin 'Lokaltog/vim-easymotion'
    Plugin 'tpope/vim-surround'
    Plugin 'tpope/vim-commentary'
    Plugin 'tpope/vim-repeat'
    Plugin 'kien/ctrlp.vim'
    Plugin 'bling/vim-airline'
    Plugin 'majutsushi/tagbar'
    Plugin 'scrooloose/syntastic'
    Plugin 'terryma/vim-expand-region'
    Plugin 'terryma/vim-multiple-cursors'
    Plugin 'terryma/vim-smooth-scroll'
    Plugin 'Valloric/YouCompleteMe'
    Plugin 'godlygeek/tabular'
    Plugin 'jnwhiteh/vim-golang'
call vundle#end()
