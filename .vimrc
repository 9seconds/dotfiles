" This is a .vimrc.
"
" Probably it is not the best vimrc you may find around but at least
" this is more or less up to date version of vim I am working with
" everyday



" =======================================
" ========== Preliminary stuff ==========
" =======================================

set nocompatible  " Remove compatibility with VIM
filetype off      " Required by NeoBundle to start



" =============================
" ========== Plugins ==========
" =============================

let g:make = 'gmake'  " Required for vimproc plugin
if system('uname -o') =~ '^GNU/'
    let g:make = 'make'
endif

if has ('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle'))
    NeoBundleFetch 'Shougo/neobundle.vim'

    NeoBundle 'altercation/vim-colors-solarized'
    NeoBundle 'bling/vim-airline'
    NeoBundle 'fatih/vim-go'
    NeoBundle 'goldfeld/vim-seek'
    NeoBundle 'hynek/vim-python-pep8-indent'
    NeoBundle 'kien/rainbow_parentheses.vim'
    NeoBundle 'Lokaltog/vim-easymotion'
    NeoBundle 'majutsushi/tagbar'
    NeoBundle 'scrooloose/nerdtree'
    NeoBundle 'Shougo/neomru.vim'
    NeoBundle 'Shougo/unite.vim'
    NeoBundle 'terryma/vim-expand-region'
    NeoBundle 'terryma/vim-multiple-cursors'
    NeoBundle 'terryma/vim-smooth-scroll'
    NeoBundle 'tpope/vim-commentary'
    NeoBundle 'tpope/vim-repeat'
    NeoBundle 'tpope/vim-surround'
    NeoBundle 'tpope/vim-unimpaired'
    NeoBundle 'Valloric/YouCompleteMe'

    NeoBundle 'Shougo/vimproc.vim', {
        \ 'build' : {
        \     'windows' : 'tools\\update-dll-mingw',
        \     'cygwin' : 'make -f make_cygwin.mak',
        \     'mac' : 'make -f make_mac.mak',
        \     'unix' : g:make,
        \    },
        \ }
call neobundle#end()

filetype plugin indent on
NeoBundleCheck



" =======================================
" =========== Common settings ===========
" =======================================

try
  lang en_us
catch
endtry

" Show the status of the current command in the status bar
set showcmd

" Set 7 lines to the cursor when scrolling vertically
set scrolloff=7

" The same but for horizontal
set sidescroll=1
set sidescrolloff=15

" Set magic for regular expressions
set magic

" Set abandonned buffer as hidden
set hidden

" Autosave and autoread
set autoread
set autowriteall

" Turn on WildMenu
set wildmenu
set wildignore=*.o,*~,*.pyc,*.pyo,.git\*,.hg\*,svn\*,idea\*,__pycache__\*

" Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Incremental search
set incsearch

" Don't redraw while executing macros (mostly for performance)
set lazyredraw

" No sounds on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Set utf8 for everything
set encoding=utf8
set termencoding=utf8
set fileencoding=utf8
set fileencodings=utf8,cp1251,koi8r,ucs-2le

" Turn VIM bullshit off
set nobackup
set nowb
set noswapfile
set viminfo=

" Set end of line always
set eol

" Explain VIM about backspaces
set backspace=indent,eol,start

" Prevents inserting two spaces after punctuation
set nojoinspaces

" New vertical split to the right
set splitright

" New horizontal split at the bottom
set splitbelow

" Invisible characters
set listchars=tab:▸\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
set showbreak=↪

" Show line numbers
set number

" Show what mode is active
set showmode

" Additional character for edit convenience
set virtualedit=onemore

" History size
set history=1000

" Always show statusline
set laststatus=2

" Use Unix as a default filetype
set ffs=unix,dos,mac

" Mouse settings
set mouse=a
set mousehide
set ttyfast
set ttymouse=xterm2

" 0 escape time
set timeoutlen=1000
set ttimeoutlen=0

" Solid line for vsplit separator
set fcs=vert:│

" Terminal with 256 colors
set t_Co=256

" Solarized
set background=dark
let g:solarized_contrast="normal"
let g:solarized_visibility="normal"
colorscheme solarized

" Disable welcome page
set shortmess=I

" I am in the boat
set relativenumber

" Resize splits if the window is resized
au VimResized * exe "normal! \<c-w>="

" Remote trailing whitespaces on save
autocmd BufWritePre * :%s/\s\+$//e



" ============================
" ========== Keymap ==========
" ============================

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

" Fast window navigation by Alt+hjkl
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Disable Q since I really bad at fast typing
map Q <nop>

" Disable highlight
map <silent> <leader>h :silent nohlsearch<cr>

" Remap VIM 0 to first non-blank character
map 0 ^

" Close the current buffer
map <leader>bd :bdelete<cr>

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

nnoremap <silent> <Leader>m :Unite -buffer-name=recent -winheight=10 file_mru<cr>
nnoremap <Leader>bl :Unite -buffer-name=buffers -winheight=10 buffer<cr>
nnoremap <Leader>f :Unite grep:.<cr>
nnoremap <silent> <C-p> :Unite -start-insert -buffer-name=files -winheight=10 file_rec/async<cr>

map <F5> :YcmCompleter GoToDefinitionElseDeclaration<cr>

" NerdTree
map <F2> :NERDTreeToggle<CR>

" TagBar
map <F3> :TagbarToggle<CR>



" =========================
" ========== Code==========
" =========================

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



" =====================================
" ========== Plugin settings ==========
" =====================================

" " YouCompleteMe settings
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

" Setup statusline airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme="solarized"

" Use AG for search
" https://github.com/ggreer/the_silver_searcher
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--nocolor --nogroup --column'
    let g:unite_source_grep_recursive_opt = ''
    let g:unite_source_rec_async_command= 'ag --nocolor --nogroup --hidden -g ""'
endif

" Unite
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom#source('file_rec/async','sorters','sorter_rank')

let g:unite_enable_start_insert = 1
let g:unite_source_file_rec_max_cache_files = 0
let g:unite_source_history_yank_enable = 1
let g:unite_split_rule = "botright"
let g:unite_force_overwrite_statusline = 0
let g:unite_winheight = 10
let g:unite_candidate_icon="➜"

autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
    let b:SuperTabDisabled=1
    imap <buffer> <C-j>   <Plug>(unite_select_next_line)
    imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
    imap <silent><buffer><expr> <C-x> unite#do_action('split')
    imap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
    imap <silent><buffer><expr> <C-t> unite#do_action('tabopen')

    nmap <buffer> <ESC> <Plug>(unite_exit)
endfunction

" Rainbow parenthesis
au VimEnter * RainbowParenthesesToggleAll
au Syntax   * RainbowParenthesesLoadRound
au Syntax   * RainbowParenthesesLoadSquare
au Syntax   * RainbowParenthesesLoadBraces



" =========================
" ========== GUI ==========
" =========================

if has('gui_running')
    noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<cr>
    noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<cr>
    noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<cr>
    noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<cr>

    set guifont=Meslo\ LG\ M\ DZ\ for\ Powerline\ 11

    set guioptions-=T  " hide toolbar
    set guioptions-=r  " hide right scrollbar
    set guioptions-=L  " hide left scrollbar
    set guioptions-=m  " hide menu bar

    " Always fullscreen
    set lines=999
    set columns=999

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
