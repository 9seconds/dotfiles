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

" Enable Python support for Neovim
if has('nvim')
  runtime! python_setup.vim
endif

let g:make = 'gmake'  " Required for vimproc plugin
if system('uname -o') =~ '^GNU/'
    let g:make = 'make'
endif

if has ('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle'))
    NeoBundleFetch 'Shougo/neobundle.vim'

    NeoBundle 'airblade/vim-gitgutter'
    NeoBundle 'benmills/vimux'
    NeoBundle 'bps/vim-textobj-python'
    NeoBundle 'chriskempson/base16-vim'
    NeoBundle 'fatih/vim-go'
    NeoBundle 'hdima/python-syntax'
    NeoBundle 'honza/dockerfile.vim'
    NeoBundle 'honza/vim-snippets'
    NeoBundle 'hynek/vim-python-pep8-indent'
    NeoBundle 'itchyny/lightline.vim'
    NeoBundle 'jistr/vim-nerdtree-tabs'
    NeoBundle 'kana/vim-textobj-indent'
    NeoBundle 'kana/vim-textobj-user'
    NeoBundle 'kien/rainbow_parentheses.vim'
    NeoBundle 'Lokaltog/vim-easymotion'
    NeoBundle 'majutsushi/tagbar'
    NeoBundle 'osyo-manga/vim-over'
    NeoBundle 'scrooloose/nerdtree'
    NeoBundle 'Shougo/neomru.vim'
    NeoBundle 'Shougo/unite.vim'
    NeoBundle 'sirver/ultisnips'
    NeoBundle 'terryma/vim-expand-region'
    NeoBundle 'terryma/vim-multiple-cursors'
    NeoBundle 'tpope/vim-commentary'
    NeoBundle 'tpope/vim-fugitive'
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

" Admit people's modelines
set modeline

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
let base16colorspace=256
colorscheme base16-tomorrow

" Disable welcome page
set shortmess=I

" I am in the boat
set relativenumber

" Resize splits if the window is resized
au VimResized * exe "normal! \<c-w>="

" Remote trailing whitespaces on save
autocmd BufWritePre * :%s/\s\+$//e

autocmd BufWritePost .vimrc source $MYVIMRC



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

nnoremap <silent> <Leader>m  :Unite -buffer-name=recent -winheight=10 file_mru<cr>
nnoremap <silent> <Leader>bl :Unite -buffer-name=buffers -winheight=10 buffer<cr>
nnoremap <silent> <Leader>f  :Unite grep:.<cr>
nnoremap <silent> <C-p>      :Unite -start-insert -buffer-name=files -winheight=10 file_rec/async<cr>

" NerdTree
map <silent> <F2> :NERDTreeTabsToggle<CR>

" TagBar
map <silent> <F3> :TagbarToggle<CR>

" YCM traveller
map <silent> <F4> :YcmCompleter GoToDefinitionElseDeclaration<cr>

" Vimux
map <silent> <F5> :VimuxPromptCommand<cr>
map <silent> <F6> :VimuxZoomRunner<cr>
map <silent> <F7> :VimuxCloseRunner<cr>
map <silent> <F8> :VimuxInterruptRunner<cr>

" Ultisnips
let g:UltiSnipsUsePythonVersion = 2
let g:UltiSnipsExpandTrigger="<Space>q"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="context"

" Python Syntax
let python_version_2 = 1
let python_highlight_all = 1

" Easy Motion
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_us = 1
nmap s <Plug>(easymotion-s2)
nmap t <Plug>(easymotion-t2)
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)



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

let s:hidden_all = 0
function! ToggleHiddenAll()
    if s:hidden_all  == 0
        let s:hidden_all = 1
        set noshowmode
        set noruler
        set laststatus=0
        set noshowcmd
        set cmdheight=1
    else
        let s:hidden_all = 0
        set showmode
        set ruler
        set laststatus=2
        set showcmd
        set cmdheight=2
    endif
endfunction

nnoremap <silent> <Leader>\ :call ToggleHiddenAll()<cr>

set formatprg=par


" =====================================
" ========== Plugin settings ==========
" =====================================

" " YouCompleteMe settings
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 0
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_min_num_of_chars_for_completion = 2

" Setup lightline
let g:lightline = {
    \     'colorscheme': 'Tomorrow_Night',
    \     'active': {
    \         'left': [
    \             ['mode', 'paste'],
    \             ['readonly', 'filename', 'modified']
    \         ]
    \     },
    \     'component_function': {
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
    elseif &ft == 'unite'
        return unite#get_status_string()
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
        \ &ft == 'unite' ? 'Unite' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! LightLineModified()
    return &ft =~ 'help' ? '' : &modified ? '✔' : &modifiable ? '' : '✖'
endfunction

function! LightLineReadOnly()
    return &ft !~? 'help' && &readonly ? '' : ''
endfunction

" TagBar
let g:tagbar_status_func = 'LightLineTagBarStatus'

function! LightLineTagBarStatus(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
    return lightline#statusline(0)
endfunction

" Use AG for search
" https://github.com/ggreer/the_silver_searcher
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '-S --nocolor --nogroup --column'
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



" ==========================
" ========== MISC ==========
" ==========================


if has('nvim')
  let g:python_host_prog="/usr/bin/python2.7"
endif