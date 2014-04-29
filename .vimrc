set nocompatible
filetype off

"
" Vundle
"
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/vundle'
Plugin 'altercation/vim-colors-solarized'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'kien/ctrlp.vim'
call vundle#end()

filetype on
filetype plugin on
filetype indent on

let mapleader = ","
set showcmd

" Set 7 lines to the cursor - when moving vertically using j/k
set scrolloff=7

" For regular expressions turn magic on
set magic
"
" " Show matching brackets when text indicator is over them
set showmatch
"
" " How many tenths of a second to blink when matching brackets
set matchtime=2

" Breaking lines with \[enter] without having to go to insert mode (myself).
nmap <leader><cr> i<cr><Esc>

nmap <silent> <C-N> :silent noh<CR>
nmap <leader>l :set list!<CR>
" Disable that goddamn 'Entering Ex mode. Type 'visual' to go to Normal mode.'
" " that I trigger 40x a day.
map Q <Nop>
" Turn on that syntax highlighting
syntax on

set sidescrolloff=15
set sidescroll=1
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>

" Why is this not a default
set hidden

" Autosave
set autowrite

" At least let yourself know what mode you're in
set showmode

cmap w!! %!sudo tee > /dev/null %


" Enable enhanced command-line completion. Presumes you have compiled
" with +wildmenu.  See :help 'wildmenu'
set wildmenu

set mouse=a
set mousehide
set history=1000
set virtualedit=onemore

set viewoptions=folds,options,cursor,unix,slash

set cursorline

set number
set ruler
set showmatch                   " Show matching brackets/parenthesis
set incsearch                   " Find as you type search
set hlsearch                    " Highlight search terms
set ignorecase
set smartcase
set autoindent                  " Indent at the same level of the previous line
set shiftwidth=4                " Use indents of 4 spaces
set expandtab                   " Tabs are spaces, not tabs
set tabstop=4                   " An indentation every four columns
set softtabstop=4               " Let backspace delete indent
set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow                  " Puts new split windows to the bottom of the current


set linespace=1

" Color scheme
set t_Co=256
syntax enable
let g:solarized_termcolors=256
let g:solarized_contrast="normal"
let g:solarized_visibility="normal"
set background=dark
colorscheme solarized

" Different hacks

" Shortcut to rapidly toggle `set list`

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬
