" Forget being compatible with good ol' vi
set nocompatible

" Get that filetype stuff happening
filetype on
filetype plugin on
filetype indent on

" Turn on that syntax highlighting
syntax on

" Why is this not a default
set hidden

" At least let yourself know what mode you're in
set showmode

" Enable enhanced command-line completion. Presumes you have compiled
" with +wildmenu.  See :help 'wildmenu'
set wildmenu

set mouse=a
set mousehide
set history=1000
set virtualedit=onemore

set viewoptions=folds,options,cursor,unix,slash

set cursorline

set ruler
set showmatch                   " Show matching brackets/parenthesis
set incsearch                   " Find as you type search
set hlsearch                    " Highlight search terms
set autoindent                  " Indent at the same level of the previous line
set shiftwidth=4                " Use indents of 4 spaces
set expandtab                   " Tabs are spaces, not tabs
set tabstop=4                   " An indentation every four columns
set softtabstop=4               " Let backspace delete indent
set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow                  " Puts new split windows to the bottom of the current

" mapleader = ','


set linespace=1

" Vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
filetype plugin indent on


" Vundle plugins
Plugin 'gmarik/vundle'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'tpope/vim-surround'

" Color scheme
set t_Co=256
syntax enable
let g:solarized_termcolors = 256
let g:solarized_termtrans = 0
let g:solarized_contrast = "normal"
let g:solarized_visibility= "normal"
set background=light
colorscheme solarized

set number

" Different hacks

map <F3> :NERDTreeToggle<CR><CR>

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>
  
" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬
