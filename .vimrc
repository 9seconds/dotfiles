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

" Vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
filetype plugin indent on


" Vundle plugins
Plugin 'gmarik/vundle'
Plugin 'altercation/vim-colors-solarized'
Plugin 'L9'
Plugin 'FuzzyFinder'
Plugin 'scrooloose/nerdtree'


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
