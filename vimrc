" This is a .vimrc.
"
" Probably it is not the best vimrc you may find around but at least
" this is more or less up to date version of vim I am working with
" everyday


" # Header          =============================================== {{{
" _____________________________________________________________________________

set nocompatible  " Remove compatibility with VIM
filetype off


" }}}
" # Plugins         =============================================== {{{
" _____________________________________________________________________________

let g:make = 'gmake'  " Required for vimproc plugin
if system('uname -o') =~ '^GNU/'
    let g:make = 'make'
endif


call plug#begin('~/.vim/plugged')
    Plug '29decibel/codeschool-vim-theme'
    Plug 'airblade/vim-gitgutter'
    Plug 'benekastah/neomake'
    Plug 'benmills/vimux'
    Plug 'davidhalter/jedi-vim', { 'for': 'python' }
    Plug 'elzr/vim-json', { 'for': 'json' }
    Plug 'fatih/vim-go', { 'for': 'go' }
    Plug 'hdima/python-syntax', { 'for': 'python' }
    Plug 'honza/dockerfile.vim', { 'for': 'Dockerfile' }
    Plug 'hynek/vim-python-pep8-indent', { 'for': 'python' }
    Plug 'itchyny/lightline.vim'
    Plug 'jmcantrell/vim-virtualenv', { 'for': 'python' }
    Plug 'junegunn/goyo.vim'
    Plug 'junegunn/limelight.vim'
    Plug 'kana/vim-textobj-user' | Plug 'kana/vim-textobj-indent' | Plug 'bps/vim-textobj-python'
    Plug 'kien/ctrlp.vim'
    " Plug 'kien/rainbow_parentheses.vim'
    Plug 'Lokaltog/vim-easymotion'
    Plug 'majutsushi/tagbar'
    Plug 'morhetz/gruvbox'
    Plug 'pangloss/vim-javascript', { 'for': 'python' }
    Plug 'scrooloose/nerdtree' | Plug 'jistr/vim-nerdtree-tabs'
    Plug 'Shougo/vimproc.vim', { 'do': 'make' }
    Plug 'terryma/vim-expand-region'
    Plug 'terryma/vim-multiple-cursors'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-surround'
    " Plug 'Yggdroot/indentLine'
call plug#end()

filetype plugin indent on


" }}}
" # Settings        =============================================== {{{
" _____________________________________________________________________________

try
    lang en_us
catch
endtry

" _____________________________________________________________________________

" Show the status of the current command in the status bar
set showcmd

" _____________________________________________________________________________

" Scrolling
set scrolloff=5
set sidescroll=1
set sidescrolloff=15

" _____________________________________________________________________________

" Set magic for regular expressions
set magic

" _____________________________________________________________________________

" Set abandonned buffer as hidden
set hidden

" _____________________________________________________________________________

" Autosave and autoread
set autoread
set autowriteall

" _____________________________________________________________________________

" Admit people's modelines
set modeline

" _____________________________________________________________________________

" Turn on WildMenu
set wildmenu
set wildignore=*.o,*~,*.pyc,*.pyo,.git\*,.hg\*,svn\*,idea\*,__pycache__\*
set wildmode=full

" _____________________________________________________________________________

" Always show current position
set ruler

" _____________________________________________________________________________

" Height of the command bar
set cmdheight=2

" _____________________________________________________________________________

" Ignore case when searching
set ignorecase
set smartcase

" _____________________________________________________________________________

" Highlight search results
set hlsearch
set incsearch

" _____________________________________________________________________________

" Don't redraw while executing macros (mostly for performance)
set lazyredraw

" _____________________________________________________________________________

" No sounds on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" _____________________________________________________________________________

" Set utf8 for everything
set encoding=utf8
set termencoding=utf8
set fileencoding=utf8
set fileencodings=utf8,cp1251,koi8r,ucs-2le

" _____________________________________________________________________________

" Turn VIM bullshit off
set nobackup
set nowb
set noswapfile
set viminfo=

" _____________________________________________________________________________

" Set end of line always
set eol

" _____________________________________________________________________________

" Explain VIM about backspaces
set backspace=indent,eol,start

" _____________________________________________________________________________

" Prevents inserting two spaces after punctuation
set nojoinspaces

" _____________________________________________________________________________

" New vertical split to the right
set splitright

" _____________________________________________________________________________

" New horizontal split at the bottom
set splitbelow

" _____________________________________________________________________________

" Invisible characters
set list
set listchars=tab:▸\ ,trail:⋅,extends:❯,precedes:❮
set showbreak=↪

" _____________________________________________________________________________

" Show line numbers
set number
set relativenumber

" _____________________________________________________________________________

" Show what mode is active
set showmode

" _____________________________________________________________________________

" Additional character for edit convenience
set virtualedit=onemore

" _____________________________________________________________________________

" History size
set history=1000

" _____________________________________________________________________________

" Always show statusline
set laststatus=2

" _____________________________________________________________________________

" Use Unix as a default filetype
set ffs=unix,dos,mac

" _____________________________________________________________________________

" Mouse settings
set mouse=a
set mousehide

" _____________________________________________________________________________

" 0 escape time
set timeoutlen=1000
set ttimeoutlen=0

" _____________________________________________________________________________

" Solid line for vsplit separator
set fcs=vert:│

" _____________________________________________________________________________

" Terminal with 256 colors
set t_Co=256

" _____________________________________________________________________________

" Solarized
set background=dark
colorscheme codeschool

" _____________________________________________________________________________

" Disable welcome page
set shortmess=I

" _____________________________________________________________________________


" Resize splits if the window is resized
au VimResized * exe "normal! \<c-w>="

" _____________________________________________________________________________

" Remote trailing whitespaces on save
autocmd BufWritePre * :%s/\s\+$//e

" _____________________________________________________________________________

" Resource vimrc on save
autocmd BufWritePost .vimrc source $MYVIMRC

" _____________________________________________________________________________

if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" _____________________________________________________________________________

" Where the hell I can find modula 2?
autocmd BufNewFile,BufReadPost *.md set filetype=markdown


" }}}}
" # Keymap          =============================================== {{{
" _____________________________________________________________________________

" No arrows :(
noremap  <up>    <nop>
noremap  <down>  <nop>
noremap  <left>  <nop>
noremap  <right> <nop>
inoremap <up>    <nop>
inoremap <down>  <nop>
inoremap <left>  <nop>
inoremap <right> <nop>

" Map Leader to the Space
let mapleader = "\<Space>"
let g:mapleader = "\<Space>"

" Fast saving on Space+w
nmap <leader>w :w!<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
cmap w!! %!sudo tee % > /dev/null%

" Reselect visual block after indent or outdent
vnoremap < <gv
vnoremap > >gv

" Reasonable navigation through wrapped lines
nnoremap j gj
nnoremap k gk
nnoremap $ g$
noremap  0 g0

" Keep search pattern at the center of the screen
nnoremap <silent> n  nzz
nnoremap <silent> N  Nzz
nnoremap <silent> *  *zz
nnoremap <silent> #  #zz
nnoremap <silent> g* g*zz
nnoremap <silent> g# g#zz

" Center screen position on fast listing
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap <C-f> <C-f>zz
nnoremap <C-b> <C-b>zz

" Fast window navigation by Alt+hjkl
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Use common way to escape insert mode
inoremap jj <ESC>

" Disable highlight
nnoremap <silent> <ESC> :noh<CR><ESC><ESC>

" Remap VIM 0 to first non-blank character
map 0 ^

" Close the current buffer
nnoremap <leader>bd :bdelete<cr>
nnoremap <leader>bs :buffers<CR>:buf<Space>

" Tab management
map <leader>tn        :tabnew<cr>
map <leader>to        :tabonly<cr>
map <leader>tc        :tabclose<cr>
map <leader>tm        :tabmove<Space>
map <leader>t<leader> :tabnext<Space>
map <leader>te        :tabedit <c-r>=expand("%:p:h")<cr>/

" Toggle between paste mode
nnoremap <silent> <Leader>1 :set paste!<cr>

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>


nnoremap Q :call <SID>QuickfixToggle()<cr>

let g:quickfix_is_open = 0
function! s:QuickfixToggle()
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
        execute g:quickfix_return_to_window . "wincmd w"
    else
        let g:quickfix_return_to_window = winnr()
        copen
        let g:quickfix_is_open = 1
    endif
endfunction


" }}}
" # Code            =============================================== {{{
" _____________________________________________________________________________


" Enable filetype related settings
filetype on
filetype plugin on
filetype indent on

" Enable syntax
syntax on

" Set rulers
let &colorcolumn="80,".join(range(120,999),",")

" Show matching brackets, parenthesis
set showmatch

" Tab is 4 spaces length
set shiftwidth=4

" No tabs, only spaces
set expandtab
set smarttab

" Indentation length
set tabstop=4

" Backspace unindent
set softtabstop=4

" Indents
set autoindent
set smartindent

" Set line breaks
set lbr
set tw=500

" Setup folding
set foldmethod=indent
set foldnestmax=10
set foldlevel=1
set nofoldenable

" Format with par
set formatprg=par

" Autocomplete menu
inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Tab>      pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <C-j>      pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <C-k>      pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"<F37>


" }}}
" # Neovim settings =============================================== {{{
" _____________________________________________________________________________


if has('nvim')
    " Python support
    runtime! python_setup.vim
    let g:python_host_prog="/usr/bin/python2.7"

    " Windows navigation
    tnoremap <A-h> <C-\><C-n><C-w>h
    tnoremap <A-j> <C-\><C-n><C-w>j
    tnoremap <A-k> <C-\><C-n><C-w>k
    tnoremap <A-l> <C-\><C-n><C-w>l
    nnoremap <A-h> <C-w>h
    nnoremap <A-j> <C-w>j
    nnoremap <A-k> <C-w>k
    nnoremap <A-l> <C-w>l

    " Teminal
    :tnoremap <A-q> <C-\><C-n>

    let g:terminal_scrollback_buffer_size = 10000
else
    set ttyfast
    set ttymouse=xterm2
endif


" }}}
" # Plugin settings =============================================== {{{
" _____________________________________________________________________________


" Lightline {{{

let g:lightline = {
    \     'colorscheme': 'Tomorrow_Night',
    \     'active': {
    \         'left': [
    \             ['mode', 'paste'],
    \             ['readonly', 'filename', 'modified'],
    \             ['fugitive']
    \         ]
    \     },
    \     'component_function': {
    \         'fugitive':     'fugitive#statusline',
    \         'fileencoding': 'LightLineFileEncoding',
    \         'fileformat':   'LightLineFileFormat',
    \         'filename':     'LightLineFileName',
    \         'filetype':     'LightLineFileType',
    \         'mode':         'LightLineMode',
    \         'modified':     'LightLineModified',
    \         'readonly':     'LightLineReadOnly'
    \     },
    \     'subseparator': {
    \         'left': '»',
    \         'right': '«'
    \     }
    \ }

function! LightLineFileEncoding()
    return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! LightLineFileFormat()
    return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFileName()
    let fname = expand('%:t')
    if fname == '__Tagbar__'
        return g:lightline.fname
    elseif fname =~ 'NERD_tree'
        return ''
    elseif fname == ''
        return '[noname]'
    else
        return fname
    endif
endfunction

function! LightLineFileType()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! LightLineMode()
    let fname = expand('%:t')
    return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! LightLineModified()
    return &ft =~ 'help' ? '' : &modified ? '✔' : &modifiable ? '' : '✖'
endfunction

function! LightLineReadOnly()
    return &ft !~? 'help' && &readonly ? '' : ''
endfunction

" }}}
" TagBar {{{

let g:tagbar_status_func = 'LightLineTagBarStatus'

function! LightLineTagBarStatus(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
    return lightline#statusline(0)
endfunction

" }}}
" IndentLine {{{

let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_leadingSpaceChar = '·'

" }}}
" VimGo {{{

let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1

autocmd BufWritePre *.go :GoImports
autocmd FileType go nmap K <Plug>(go-doc)
autocmd FileType go nmap <leader>g <Plug>(go-def-tab)
autocmd FileType go nmap <leader>n <Plug>(go-callers)
autocmd FileType go nmap <leader>r <Plug>(go-rename)

" }}}
" CtrlP {{{

let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
    \ --ignore .git
    \ --ignore .svn
    \ --ignore .hg
    \ --ignore .DS_Store
    \ --ignore "**/*.pyc"
    \ -g ""'

" }}}
" Jedi {{{

let g:jedi#popup_on_dot = 0
let g:jedi#show_call_signatures = 2
let g:jedi#use_tabs_not_buffers = 1

" }}}
" NerdTree and NerdTreeTabs {{{

let g:nerdtree_tabs_open_on_gui_startup = 0
let g:nerdtree_tabs_open_on_console_startup = 0

map <silent> <F2> :NERDTreeTabsToggle<CR>

" }}}
" Python Syntax {{{

let python_version_2 = 1
let python_highlight_all = 1

" }}}
" Easy Motion {{{

let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_us = 1
nmap s <Plug>(easymotion-s2)
nmap t <Plug>(easymotion-t2)
map  / <Plug>(easymotion-sn)\v
omap / <Plug>(easymotion-tn)\v
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

" }}}
" Goyo {{{
let g:goyo_margin_top = 1
let g:goyo_width = 120
let g:goyo_linenr = 0
nnoremap <silent> <Leader>+ :Goyo<cr>

function! s:goyo_enter()
    silent !tmux set status off
    Limelight
endfunction

function! s:goyo_leave()
    silent !tmux set status on
    Limelight!
endfunction

autocmd! User GoyoEnter
autocmd! User GoyoLeave
autocmd  User GoyoEnter nested call <SID>goyo_enter()
autocmd  User GoyoLeave nested call <SID>goyo_leave()

" }}}
" Limelight {{{
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'

" Default: 0.5
let g:limelight_default_coefficient = 0.7

" Number of preceding/following paragraphs to include (default: 0)
let g:limelight_paragraph_span = 1

" }}}
" TagBar {{{

map <silent> <F3> :TagbarToggle<CR>

" }}}
" Vimux {{{

map <silent> <F5> :VimuxPromptCommand<cr>
map <silent> <F6> :VimuxZoomRunner<cr>
map <silent> <F7> :VimuxCloseRunner<cr>
map <silent> <F8> :VimuxInterruptRunner<cr>

" }}}

" }}}
" # GUI             =============================================== {{{
" _____________________________________________________________________________


if has('gui_running')
    let g:gruvbox_italic = 1

    set guioptions-=T  " hide toolbar
    set guioptions-=r  " hide right scrollbar
    set guioptions-=L  " hide left scrollbar
    set guioptions-=m  " hide menu bar

    set guifont=Meslo\ LG\ L\ DZ\ 9

    set guitablabel=%M\ %t
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END

    " Make copy/cut/paste work with GUI as expected
    nnoremap <silent> y "+y
    vnoremap <silent> y "+y
    nnoremap <silent><Leader>p "+gP
endif


" }}}
" # Misc            =============================================== {{{
" _____________________________________________________________________________


" Fold vimrc
autocmd FileType vim setlocal foldmethod=marker
autocmd FileType vim setlocal foldlevel=0
autocmd FileType vim setlocal foldenable

" _____________________________________________________________________________

" Use AG for search
" https://github.com/ggreer/the_silver_searcher
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
endif


" }}}
