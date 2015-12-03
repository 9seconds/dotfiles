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

" Autoinstall vim-plug if absent
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $VIMRC
endif

call plug#begin('~/.vim/plugged')
    " Active plugs {{{
    Plug 'airblade/vim-rooter'
    Plug 'benekastah/neomake'
    Plug 'benmills/vimux'
    Plug 'bling/vim-airline'
    Plug 'chrisbra/NrrwRgn'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'davidhalter/jedi-vim', { 'for': 'python' }
    Plug 'elzr/vim-json', { 'for': 'json' }
    Plug 'ervandew/supertab'
    Plug 'fatih/vim-go', { 'for': 'go' }
    Plug 'gavocanov/vim-js-indent', { 'for': 'javascript' }
    Plug 'hdima/python-syntax', { 'for': 'python' }
    Plug 'honza/dockerfile.vim', { 'for': 'Dockerfile' }
    Plug 'honza/vim-snippets'
    Plug 'hynek/vim-python-pep8-indent', { 'for': 'python' }
    Plug 'jmcantrell/vim-virtualenv', { 'for': 'python' }
    Plug 'junegunn/fzf', { 'dir': '~/.fzf' } | Plug 'junegunn/fzf.vim'
    Plug 'justinmk/vim-sneak'
    Plug 'kana/vim-textobj-user' | Plug 'kana/vim-textobj-indent' | Plug 'bps/vim-textobj-python' | Plug 'machakann/vim-textobj-delimited'
    Plug 'kshenoy/vim-signature'
    Plug 'ludovicchabant/vim-gutentags'
    Plug 'mhinz/vim-signify'
    Plug 'mkitt/tabline.vim'
    Plug 'morhetz/gruvbox'
    Plug 'othree/html5.vim', { 'for': ['html', 'javascript'] }
    Plug 'othree/yajs.vim', { 'for': 'javascript' } | Plug 'othree/javascript-libraries-syntax.vim', { 'for': 'javascript' }
    Plug 'phildawes/racer', { 'for': 'rust', 'do': 'cargo build --release' }
    Plug 'rking/ag.vim'
    Plug 'rstacruz/vim-closer'
    Plug 'rust-lang/rust.vim', { 'for': 'rust' }
    Plug 'scrooloose/nerdtree' | Plug 'jistr/vim-nerdtree-tabs'
    Plug 'Shougo/vimproc.vim', { 'do': 'make' }
    Plug 'SirVer/ultisnips'
    Plug 'ternjs/tern_for_vim', { 'for': 'javascript', 'do': 'npm install' }
    Plug 'terryma/vim-expand-region'
    Plug 'terryma/vim-multiple-cursors'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-endwise'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-markdown', { 'for': 'markdown' }
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
    Plug 'unblevable/quick-scope'
    Plug 'Valloric/python-indent'
    " }}}
    " Disabled plugs {{{
    " Plug 'ciaranm/detectindent'
    " Plug 'ctrlpvim/ctrlp.vim' | Plug 'tacahiroy/ctrlp-funky'
    " Plug 'junegunn/goyo.vim'
    " Plug 'junegunn/limelight.vim'
    " Plug 'junegunn/vim-pseudocl' | Plug 'junegunn/vim-oblique'
    " Plug 'kristijanhusak/vim-hybrid-material'
    " Plug 'majutsushi/tagbar'
    " }}}
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
" Use /g always
set gdefault

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
if !has('nvim')
    set encoding=utf8
endif
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
let g:enable_bold_font = 1
let g:gruvbox_italic=1
colorscheme gruvbox
" colorscheme hybrid_material

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
let mapleader        = "\<Space>"
let g:mapleader      = "\<Space>"
let maplocalleader   = "\<Space>"
let g:maplocalleader = "\<Space>"

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

" Tab management
nnoremap <leader>tc :tabclose<cr>

" Fast tab switch
nnoremap <silent> <Leader>1 1gt<cr>
nnoremap <silent> <Leader>2 2gt<cr>
nnoremap <silent> <Leader>3 3gt<cr>
nnoremap <silent> <Leader>4 4gt<cr>
nnoremap <silent> <Leader>5 5gt<cr>
nnoremap <silent> <Leader>6 6gt<cr>
nnoremap <silent> <Leader>7 7gt<cr>
nnoremap <silent> <Leader>8 8gt<cr>
nnoremap <silent> <Leader>9 9gt<cr>

" Switch CWD to the directory of the open buffer
" map <leader>cd :cd %:p:h<cr>:pwd<cr>

" QuickFix setup
nnoremap <silent> Q :call <SID>QuickfixToggle()<cr>

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

" Do not show color column in a quickfix for a greater good
augroup qf_colorcolumn
    autocmd!
    autocmd FileType qf setlocal colorcolumn=
augroup END


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

" }}}
" # Neovim settings =============================================== {{{
" _____________________________________________________________________________


if has('nvim')
    " Python support
    runtime! python_setup.vim
    let g:python_host_prog="/usr/bin/python2.7"

    " TUI support
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1

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


" Airline {{{

let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_theme = 'gruvbox'
let g:airline_powerline_fonts = 0

" }}}
" DetectIndent {{{

" autocmd BufReadPost * :DetectIndent

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

" let g:ctrlp_custom_ignore = {
"   \ 'dir':  '\v[\/]\.(git|hg|svn)$',
"   \ 'file': '\v\.(pyc|pyo|exe|so|dll)$'
"   \ }

" let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
"     \ --ignore "**/*.pyc"
"     \ --ignore ".git"
"     \ --ignore ".svn"
"     \ -g ""'

" let g:ctrlp_funky_matchtype = 'path'
" let g:ctrlp_funky_syntax_highlight = 1

" map <leader>bl :CtrlPBuffer<cr>
" map <leader>bf :CtrlPFunky<cr>

" }}}
" Jedi {{{

let g:jedi#popup_on_dot = 0
let g:jedi#show_call_signatures = 2
let g:jedi#use_tabs_not_buffers = 1

nnoremap <leader>jd :call jedi#goto()<cr>
nnoremap <leader>jg :call jedi#goto_assignments()<cr>
nnoremap <leader>jk :call jedi#show_documentation()<cr>
nnoremap <leader>jr :call jedi#rename()<cr>
nnoremap <leader>jn :call jedi#usages()<cr>

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
" Rooter {{{

let g:rooter_use_lcd = 1
let g:rooter_silent_chdir = 1

" }}}
" TagBar {{{

map <silent> <F3> :TagbarToggle<CR>

" }}}
" Supertab {{{

let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:SuperTabLongestEnhanced = 1

" }}}
" Vimux {{{

nnoremap <silent> <F5> :VimuxPromptCommand<cr>
nnoremap <silent> <F6> :VimuxCloseRunner<cr>
nnoremap <silent> <F7> :VimuxZoomRunner<cr>
nnoremap <silent> <F8> :VimuxInterruptRunner<cr>

" }}}
" Racer {{{

let g:racer_cmd = "~/.vim/plugged/racer/target/release/racer"

" }}}
" Ag {{{

let g:ag_working_path_mode="r"

" }}}
" UltiSnips {{{

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsEditSplit="vertical"

" }}}
" Signify {{{

let g:signify_vcs_list = [ 'git' ]
let g:signify_update_on_bufenter = 1

" }}}
" Neomake {{{

let g:neomake_python_enabled_makers = ['pep8', 'flake8', 'python']

nnoremap <leader>m :Neomake<cr>

autocmd BufWritePost *.py :Neomake

" }}}
" FZF {{{

let g:fzf_nvim_statusline = 0

nnoremap <silent> <leader>ff :Files<cr>
nnoremap <silent> <leader>fb :Buffers<cr>
nnoremap <silent> <leader>ft :BTags<cr>
nnoremap <silent> <leader>fa :Tags<cr>
nnoremap <silent> <leader>/  :call SearchWordWithAg()<cr>
vnoremap <silent> <leader>/  :call SearchVisualSelectionWithAg()<cr>

function! SearchWordWithAg()
    execute 'Ag' expand('<cword>')
endfunction

function! SearchVisualSelectionWithAg() range
    let old_reg = getreg('"')
    let old_regtype = getregtype('"')
    let old_clipboard = &clipboard

    set clipboard&
    normal! ""gvy
    let selection = getreg('"')
    call setreg('"', old_reg, old_regtype)
    let &clipboard = old_clipboard

    execute 'Ag' selection
endfunction


" }}}
" Gutentags {{{

let g:gutentags_generate_on_missing = 0
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_new = 0
let g:gutentags_exclude = [
    \ '*.min.js',
    \ '*html*',
    \ 'jquery*.js',
    \ '*/node_modules/*',
    \ '*.pyc',
    \ '*.pyo'
    \ ]

nnoremap <leader>q :GutentagsUpdate!<cr>

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
    set guifont=Droid\ Sans\ Mono\ 10
    if executable("wmctrl")
        au GUIEnter * call system('wmctrl -i -b add,maximized_vert,maximized_horz -r '.v:windowid)
    else
        set lines=999 columns=999
    endif

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
    set grepprg=ag\ --vimgrep
endif


" }}}
