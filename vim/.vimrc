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

call plug#begin('~/.vim/plugged')
    if has('nvim')
        Plug 'Shougo/deoplete.nvim' |
            \ Plug 'zchee/deoplete-jedi' |
            \ Plug 'carlitux/deoplete-ternjs'
    endif

    Plug 'airblade/vim-rooter'
    Plug 'neomake/neomake'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'benmills/vimux'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'davidhalter/jedi-vim', { 'for': 'python' }
    Plug 'hynek/vim-python-pep8-indent', { 'for': 'python' }
    Plug 'junegunn/vim-easy-align'
    Plug 'junegunn/vim-peekaboo'
    Plug 'justinmk/vim-sneak'
    Plug 'jiangmiao/auto-pairs'
    Plug 'kshenoy/vim-signature'
    Plug 'lambdalisue/vim-pyenv'
    Plug 'ludovicchabant/vim-gutentags'
    Plug 'mhinz/vim-signify'
    Plug 'mkitt/tabline.vim'
    Plug 'morhetz/gruvbox'
    Plug 'othree/html5.vim', { 'for': ['html', 'javascript'] }
    Plug 'rust-lang/rust.vim', { 'for': 'rust' }
    Plug 'sheerun/vim-polyglot'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-endwise'
    Plug 'tpope/vim-markdown', { 'for': 'markdown' }
    Plug 'tpope/vim-repeat'
    Plug 'janko-m/vim-test'
    Plug 'tpope/vim-sleuth'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-unimpaired'
    Plug 'wellle/targets.vim'
    Plug 'wellle/tmux-complete.vim'
    Plug 'wellle/visual-split.vim'
    Plug 'scrooloose/nerdtree' | Plug 'jistr/vim-nerdtree-tabs'
    Plug 'equalsraf/neovim-gui-shim'

    Plug 'kana/vim-textobj-user' |
        \ Plug 'kana/vim-textobj-indent' |
        \ Plug 'bps/vim-textobj-python', { 'for': 'python' } |
        \ Plug 'machakann/vim-textobj-delimited' |
        \ Plug 'coderifous/textobj-word-column.vim'
    Plug 'othree/yajs.vim', { 'for': 'javascript' } |
        \ Plug 'othree/javascript-libraries-syntax.vim', { 'for': 'javascript' }

    if executable('go')
        Plug 'fatih/vim-go', { 'for': 'go' }
    endif

    if executable('fzf')
        Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' } |
            \ Plug 'junegunn/fzf.vim' |
            \ Plug 'tweekmonster/fzf-filemru'
    else
        Plug 'ctrlpvim/ctrlp.vim'
    endif

    if v:version >= 704
        Plug 'SirVer/ultisnips'
    endif

    if executable('lein')
        Plug 'tpope/vim-fireplace', { 'for': 'clojure' } |
            \ Plug 'tpope/vim-salve', { 'for': 'clojure' }
    endif
call plug#end()

filetype plugin indent on

" }}}
" # Settings        =============================================== {{{
" _____________________________________________________________________________

try
    lang en_us
catch
endtry

try
    set termguicolors
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
set wildignore=*.o,*~,*.pyc,*.pyo,.git\*,.hg\*,svn\*,idea\*,__pycache__\*,.tox
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

" -----------------------------------------------------------------------------

" Break indentation
set breakindent
set breakindentopt=shift:2

" _____________________________________________________________________________

" Show line numbers
set number
if v:version >= 703
    set relativenumber
endif

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

" -----------------------------------------------------------------------------

" Session settings
set sessionoptions-=options

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

let g:enable_bold_font          = 1
let g:gruvbox_underline         = 1
let g:gruvbox_undercurl         = 1
let g:gruvbox_contrast_dark     = "soft"
let g:gruvbox_italicize_strings = 1

if has('nvim')
    let g:gruvbox_italic = 1
endif

set background=dark
colorscheme gruvbox

" _____________________________________________________________________________

" Disable welcome page
set shortmess=I

" Disable preview on completeopt
set completeopt-=preview

" -----------------------------------------------------------------------------

" netrw settings
let g:netrw_liststyle    = 3
let g:netrw_browse_split = 4
let g:netrw_altv         = 1
let g:netrw_winsize      = 25
let g:netrw_banner       = 0

" _____________________________________________________________________________

augroup VimDefault
    autocmd!
    autocmd VimResized             *         exe "normal! \<c-w>="
    autocmd BufWritePre            *         :%s/\s\+$//e
    autocmd BufNewFile,BufReadPost *.md      set filetype=markdown
    autocmd BufNewFile,BufReadPost *.journal set filetype=journal
    autocmd FileType               yaml      set sw=2
    autocmd FileType               make      set noet
augroup END

" _____________________________________________________________________________

if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif



" }}}
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
nnoremap <silent> <leader>w :update<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
cnoremap w!! w !sudo tee > /dev/null %

" Put /v everywhere on search
nnoremap / /\v
vnoremap / /\v
cnoremap %s/ %smagic/
cnoremap \>s/ \>smagic/
nnoremap :g/ :g/\v
nnoremap :g// :g//

" Reselect visual block after indent or outdent
vnoremap < <gv
vnoremap > >gv

" Reasonable navigation through wrapped lines
nnoremap j gj
nnoremap k gk
nnoremap $ g$
nnoremap 0 ^

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
nnoremap <C-h>    <C-w>h
nnoremap <C-j>    <C-w>j
nnoremap <C-k>    <C-w>k
nnoremap <C-l>    <C-w>l
nnoremap <silent> <C-x> :resize<cr>:vertical resize<cr>

" Disable highlight
nnoremap <Leader>h :nohl<cr>

" Close the current buffer
nnoremap <leader>bd :Bdelete<cr>

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

" Do not jump on star
nnoremap * *``

" QuickFix setup
nnoremap <silent> Q :call <SID>QuickfixToggle()<cr>

" Faster window close
nnoremap <silent> <Leader>qq :q<cr>
nnoremap <silent> <Leader>qa :qa<cr>

" Grep function
nnoremap <Leader>gp :Grep<space>

" Esc!
inoremap jk <esc>


" _____________________________________________________________________________

let g:quickfix_is_open = 0
function! s:QuickfixToggle()
    if g:quickfix_is_open
        cclose
        lclose
        let g:quickfix_is_open = 0
        execute g:quickfix_return_to_window . "wincmd w"
    else
        let g:quickfix_return_to_window = winnr()
        copen
        let g:quickfix_is_open = 1
    endif
endfunction

" Do not show color column in a quickfix for a greater good
if v:version >= 703
    augroup qf_colorcolumn
        autocmd!
        autocmd FileType qf setlocal colorcolumn=
    augroup END
endif

" _____________________________________________________________________________

if executable('ag')
    set grepprg=ag\ --vimgrep\ $*
    set grepformat=%f:%l:%c:%m

    command! -nargs=* -complete=file -bar Grep silent! grep! <args>|cwindow|redraw!
    nnoremap <silent> gs :execute "grep! " . shellescape(expand("<cword>"))<cr>:redraw!<cr>:copen<cr>
else
    command! -nargs=* -complete=file -bar Grep silent! grep! -Rni <args> .|cwindow|redraw!
    nnoremap <silent> gs :execute "grep! -Rni " . shellescape(expand("<cword>")) . " ."<cr>:redraw!<cr>:copen<cr>
endif


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
if v:version >= 703
    let &colorcolumn="80,".join(range(120,999),",")
endif

" Show matching brackets, parenthesis
set showmatch

" Tab is 4 spaces length
set shiftwidth=4

" No tabs, only spaces
set expandtab
set smarttab

" Indentation length
set tabstop=4

" But for yaml keep 2 characters, pls
autocmd FileType yaml setlocal tabstop=2 shiftwidth=2

" Smarter cursorline
set cursorline
autocmd InsertLeave,WinEnter * set cursorline
autocmd InsertEnter,WinLeave * set nocursorline

" Backspace unindent
set softtabstop=4

" Indents
set autoindent
set smartindent

" http://vim.wikia.com/wiki/VimTip644
inoremap # X<BS>#

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

" Pythons
let g:python_host_prog  = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'


" }}}
" # Neovim settings =============================================== {{{
" _____________________________________________________________________________


if has('nvim')
    " Python support
    runtime! python_setup.vim

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

    let g:terminal_color_0  = '#2e3436'
    let g:terminal_color_1  = '#cc0000'
    let g:terminal_color_2  = '#4e9a06'
    let g:terminal_color_3  = '#c4a000'
    let g:terminal_color_4  = '#3465a4'
    let g:terminal_color_5  = '#75507b'
    let g:terminal_color_6  = '#0b939b'
    let g:terminal_color_7  = '#d3d7cf'
    let g:terminal_color_8  = '#555753'
    let g:terminal_color_9  = '#ef2929'
    let g:terminal_color_10 = '#8ae234'
    let g:terminal_color_11 = '#fce94f'
    let g:terminal_color_12 = '#729fcf'
    let g:terminal_color_13 = '#ad7fa8'
    let g:terminal_color_14 = '#00f5e9'
    let g:terminal_color_15 = '#eeeeec'

    let g:terminal_scrollback_buffer_size = 10000
else
    set ttyfast
    set ttymouse=xterm2
endif


" }}}
" # Plugin settings =============================================== {{{
" _____________________________________________________________________________

" VimGo {{{

let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods   = 1
let g:go_highlight_structs   = 1

augroup Go
    autocmd!
    autocmd BufWritePre *.go :GoImports
    autocmd FileType    go   nmap K         <Plug>(go-doc)
    autocmd FileType    go   nmap <leader>g <Plug>(go-def-tab)
    autocmd FileType    go   nmap <leader>n <Plug>(go-callers)
    autocmd FileType    go   nmap <leader>r <Plug>(go-rename)
augroup END

" }}}
" CtrlP {{{

if !executable('fzf')
    let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v[\/]\.(git|hg|svn)$',
      \ 'file': '\v\.(pyc|pyo|exe|so|dll)$'
      \ }

    if executable('ag')
        let g:ctrlp_user_command = {
            \ 'types': {
                \ 1: ['.git', 'cd %s && git ls-files'],
                \ 2: ['.hg', 'hg --cwd %s locate -I .'],
                \ },
            \ 'fallback': 'ag %s -i --nocolor --nogroup --hidden
                \ --ignore "**/*.pyc"
                \ --ignore ".git"
                \ --ignore ".svn"
                \ -g ""'
        \ }
        let g:ctrlp_use_caching = 0
    else
        let g:ctrlp_user_command = {
            \ 'types': {
                \ 1: ['.git', 'cd %s && git ls-files'],
                \ 2: ['.hg', 'hg --cwd %s locate -I .'],
                \ },
            \ 'fallback': 'find %s -type f'
        \ }
    endif

    let g:ctrlp_map = ''
    let g:ctrlp_cmd = 'CtrlP'

    nnoremap <silent> <leader>ff :CtrlP<cr>
    nnoremap <silent> <leader>fp :CtrlP<cr>
    nnoremap <silent> <leader>fb :CtrlPBuffer<cr>
    nnoremap <silent> <leader>ft :CtrlPBufTag<cr>
    nnoremap <silent> <leader>fa :CtrlPTag<cr>
endif

" }}}
" NerdTree and NerdTreeTabs {{{

let g:nerdtree_tabs_open_on_gui_startup     = 0
let g:nerdtree_tabs_open_on_console_startup = 0

let NERDTreeIgnore = ['\.py[co]$', '__pycache__']

map <silent> <F2> :NERDTreeTabsToggle<CR>
map <silent> <F3> :NERDTreeFind<CR>

" }}}
" Python Syntax {{{

let python_version_2     = 1
let python_highlight_all = 1

" }}}
" Rooter {{{

let g:rooter_use_lcd      = 1
let g:rooter_silent_chdir = 1

" }}}
" Vimux {{{

nnoremap <silent> <F5> :VimuxPromptCommand<cr>
nnoremap <silent> <F6> :VimuxRunLastCommand<cr>
nnoremap <silent> <F7> :VimuxCloseRunner<cr>
nnoremap <silent> <F8> :VimuxInterruptRunner<cr>
nnoremap <silent> <F9> :VimuxZoomRunner<cr>

let g:VimuxOrientation  = "h"
let g:VimuxHeight       = "45"
let g:VimuxPromptString = "tmux> "
let g:VimuxRunnerType   = "pane"

" }}}
" UltiSnips {{{

let g:UltiSnipsExpandTrigger       = "<c-j>"
let g:UltiSnipsJumpForwardTrigger  = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
let g:UltiSnipsEditSplit           = "vertical"

let g:UltiSnipsSnippetsDir        = "~/.ultisnips"
let g:UltiSnipsSnippetDirectories = [$HOME.'/.ultisnips']

" }}}
" Signify {{{

let g:signify_vcs_list           = [ 'git' ]
let g:signify_update_on_bufenter = 1

" }}}
" Neomake {{{

let g:neomake_python_enabled_makers     = ['flake8']
let g:neomake_sh_enabled_makers         = ['shellcheck']
let g:neomake_go_enabled_makers         = ['golint']
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_verbose                   = -1

nnoremap <leader>m :Neomake<cr>

augroup NeoMake
    au!
    autocmd BufWritePost,BufEnter *.py,*.sh,*.js,*.go Neomake
augroup END

" }}}
" FZF {{{

if executable('fzf')
    command! -nargs=* -complete=file -bar Grep silent! Ag <args>

    nnoremap <silent> <leader>ff :FilesMru --tiebreak=end<cr>
    nnoremap <silent> <leader>fp :ProjectMru<cr>
    nnoremap <silent> <leader>fb :Buffers<cr>
    nnoremap <silent> <leader>ft :BTags<cr>
    nnoremap <silent> <leader>fa :Tags<cr>
    nnoremap <silent> <leader>fl :Lines<cr>
    nnoremap <silent> <leader>fm :Marks<cr>
    nnoremap <silent> gs         :execute "Ag " . expand("<cword>")<cr>
endif

" }}}
" Gutentags {{{

let g:gutentags_generate_on_missing = 0
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_new = 0
let g:gutentags_exclude = [
    \ '*.min.js',
    \ '*html*',
    \ 'jquery*.js',
    \ 'node_modules',
    \ '*.pyc',
    \ '*.pyo',
    \ '.tox',
    \ ]

nnoremap <leader>e :GutentagsUpdate!<cr>

" }}}
" Vim-test {{{

nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tv :TestVisit<CR>

if !empty($TMUX)
    let test#strategy = "vimux"
else
    let test#strategy = "neovim"
endif

" }}}
" Session {{{

let g:session_autoload          = "no"
let g:session_autosave_periodic = 1
let g:session_autosave_silent   = 1
let g:session_autosave_to       = "__last__"
let g:session_autosave          = "yes"
let g:session_command_aliases   = 1
let g:session_default_overwrite = 0
let g:session_extension         = ".session"

" }}}
" Deoplete {{{

let g:deoplete#enable_at_startup = 1
let g:deoplete#max_list          = 20

inoremap <silent><expr> <Tab>   pumvisible() ? "\<C-n>" : deoplete#mappings#manual_complete()
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : deoplete#mappings#manual_complete()

" }}}
" Jedi {{{

let g:jedi#completions_enabled = 0

let g:jedi#goto_command          = "<leader>yg"
let g:jedi#documentation_command = "<leader>yd"
let g:jedi#usages_command        = "<leader>yr"
let g:jedi#rename_command        = "<leader>yn"

" }}}
" Easy Align {{{

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" }}}
" Braceless {{{

let g:braceless_auto_dedent_gap = 2

" }}}
" HardTime {{{

nnoremap <F12> :HardTimeToggle<cr>

let g:hardtime_default_on             = 1
let g:hardtime_ignore_buffer_patterns = ["NERD.*"]
let g:hardtime_ignore_quickfix        = 1
let g:hardtime_allow_different_key    = 1
let g:hardtime_maxcount               = 2

" Notes {{{

let g:notes_directories = ['~/Sync/Main/notes']

" }}}
" Sneak {{{

let g:sneak#streak     = 1
let g:sneak#use_ic_scs = 1

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
    set guifont=Fira\ Mono\ 11
    set guitablabel=%M\ %t
    set ttimeoutlen=10

    if executable("wmctrl")
        au GUIEnter * call system('wmctrl -i -b add,maximized_vert,maximized_horz -r '.v:windowid)
    else
        set lines=999 columns=999
    endif

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
augroup VimFolds
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType vim setlocal foldlevel=0
    autocmd FileType vim setlocal foldenable
augroup END

" Changes in hilight
hi StatusLine guibg=#7c6f64 guifg=#3c3836

" }}}
