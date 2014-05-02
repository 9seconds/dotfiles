set nocompatible
filetype off


" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
    Plugin 'gmarik/vundle'
    Plugin 'altercation/vim-colors-solarized'
    Plugin 'Lokaltog/vim-easymotion'
    Plugin 'tpope/vim-surround'
    Plugin 'tpope/vim-commentary'
    Plugin 'tpope/vim-fugitive'
    Plugin 'kien/ctrlp.vim'
    Plugin 'bling/vim-airline'
    Plugin 'majutsushi/tagbar'
    Plugin 'scrooloose/syntastic'
    Plugin 'terryma/vim-expand-region'
    Plugin 'terryma/vim-multiple-cursors'
    Plugin 'terryma/vim-smooth-scroll'
    Plugin 'Valloric/YouCompleteMe'
    Plugin 'Raimondi/delimitMate'
call vundle#end()


" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Common stuff
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype on
filetype plugin on
filetype indent on

syntax on


" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key mappings
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set space as a leader key
let mapleader="\<Space>"

" Leader + Enter as O in normal mode
nmap <leader><cr> o<Esc>
nmap <leader>\ O<Esc>

" Disable current highlight by Ctrl+H
nmap <silent> <C-H> :silent noh<CR>

" Show invisibles by Leader + l
nmap <leader>l :set list!<CR>

" Disable Ex mode. I do not need it yet
map Q <Nop>

" No way back. No arrows :(
nnoremap <up>    <nop>
nnoremap <down>  <nop>
nnoremap <left>  <nop>
nnoremap <right> <nop>
inoremap <up>    <nop>
inoremap <down>  <nop>
inoremap <left>  <nop>

" Reselect visual block after indent or outdent
vnoremap < <gv
vnoremap > >gv

" Reasonable navigation through wrapped lines
nnoremap j gj
nnoremap k gk

" Keep search pattern at the center of the screen
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz
nnoremap <silent> g# g#zz

" Fast window navigation by Alt+hjkl
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Sugar for buffer listing
map <F2> :ls<CR>:b<Space>

" Toggle TagBar
nmap <F8> :TagbarToggle<CR>

" Smooth scrolling
if has('gui_running')
    noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
    noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
    noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
    noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>
endif

" YouCompleteMe settings
let g:ycm_autoclose_preview_window_after_completion=1
nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>


" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Different settings
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Show the status of the current command in the status bar
set showcmd

" Set 7 lines to the cursor - when moving vertically using j/k
set scrolloff=7

" Good to have if I forgot about sudo
cmap w!! %!sudo tee > /dev/null %

" The same as scrolloff but for horizontal
set sidescroll=1
set sidescrolloff=15

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set matchtime=2

" Why is this not a default
set hidden

" Explain VIM about backspaces
set backspace=indent,eol,start

" Autosave
set autowrite

" At least let yourself know what mode you're in
set showmode

" Enable enhanced command-line completion.
set wildmenu

" Set line numbers
set number

" Ok, finally I got why do you all need for relative numbers. I'm in the van!
set relativenumber

" Mouse settings
set mouse=a
set mousehide
set ttyfast
set ttymouse=xterm2

" Always show cursor
set ruler

" Highlight current row
" set cursorline

" Highlight current column (so it is like crosshair)
" set cursorcolumn

" Rulers. 80 is so-so, but after 120 goes open space
let &colorcolumn="80,".join(range(120,999),",")

" Make the 'cw' and like commands put a $ at the end
set cpoptions=ces$

" Find as you type. Like in browsers, pretty convenient
set incsearch

" Highlight search terms
set hlsearch

" Additional character for edit convenience
set virtualedit=onemore

" Undo depth
set history=1000

" Show matching brackets, parenthesis
set showmatch

" Do not bother about the case when search (as I usually do)
set ignorecase

" But if I put case, use case sensitive search
set smartcase

" Auto indenting lines. Since I code, this is a must
set autoindent

" Tab is 4 spaces length
set shiftwidth=4

" I do not use tabs. I hate tabs
set expandtab

" An indentation length
set tabstop=4

" Backpace unindents. Make sense
set softtabstop=4

" Prevents inserting two spaces after punctuation. Why is it not default?
set nojoinspaces

" New vertical split to the right. At least we have an order now
set splitright

" New horizontal split at the bottom of the current. The same, order
set splitbelow

" Linespace height. I guess this is for GVim mostly
set linespace=4

" Invisible chars presentation
set listchars=tab:▸\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
set showbreak=↪

" Set new line at the end of the file
set eol

" Always show statusline
set laststatus=2

" No backup or swaps, please
set nobackup
set nowritebackup
set noswapfile

" Encodings. Let's be reasonable, we only use UTF-8 everywhere now
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf8,cp1251,koi8r,cp866,ucs-2le

" Setup statusline airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Color scheme
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set t_Co=256
let g:solarized_contrast="normal"
let g:solarized_visibility="normal"
set background=dark
colorscheme solarized


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Different hacks
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Resize splits if the window is resized
au VimResized * exe "normal! \<c-w>="

" Remove trailing whitespaces on save
autocmd BufWritePre * :%s/\s\+$//e

" Ignore some folders and files for CtrlP indexing
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.yardoc\|public$|log\|tmp$',
  \ 'file': '\.so$\|\.dat$|\.DS_Store$'
  \ }

" Use AG for CtrlP search
" https://github.com/ggreer/the_silver_searcher
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command = 'ag %s -lSf --nocolor -g ""'
endif

" Disable bullshit from graphical VIM
if has('gui_running')
    set guioptions-=T
    set guioptions-=r

    set guifont=Meslo\ LG\ M\ DZ\ for\ Powerline\ 11
endif
