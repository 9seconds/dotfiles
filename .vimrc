set nocompatible              " be iMproved, required
filetype off                  " required


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
