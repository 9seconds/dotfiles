" This is a .vimrc.
"
" Probably it is not the best vimrc you may find around but at least
" this is more or less up to date version of vim I am working with
" everyday


set nocompatible  " Remove compatibility with VIM
filetype off

" # Plugins         =============================================== {{{
" _____________________________________________________________________________

call plug#begin('~/.vim/plugged')
    if has('nvim')
        Plug 'Shougo/deoplete.nvim' |
            \ Plug 'zchee/deoplete-jedi', { 'for': 'python' } |
            \ Plug 'carlitux/deoplete-ternjs', { 'for': ['json', 'javascript'] } |
            \ Plug 'zchee/deoplete-go', { 'for': 'go' }
        Plug 'equalsraf/neovim-gui-shim'
    endif

    Plug 'airblade/vim-rooter'
    Plug 'benmills/vimux'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'davidhalter/jedi-vim', { 'for': 'python' }
    Plug 'editorconfig/editorconfig-vim'
    Plug 'fatih/vim-go', { 'for': 'go' }
    Plug 'hynek/vim-python-pep8-indent', { 'for': 'python' }
    Plug 'janko-m/vim-test'
    Plug 'jiangmiao/auto-pairs'
    Plug 'junegunn/vim-easy-align'
    Plug 'junegunn/vim-peekaboo'
    Plug 'junegunn/vim-slash'
    Plug 'justinmk/vim-sneak'
    Plug 'kshenoy/vim-signature'
    Plug 'lambdalisue/vim-pyenv'
    Plug 'ludovicchabant/vim-gutentags'
    Plug 'mhinz/vim-signify'
    Plug 'mkitt/tabline.vim'
    Plug 'morhetz/gruvbox'
    Plug 'w0rp/ale'
    Plug 'othree/html5.vim', { 'for': ['html', 'javascript', 'vue'] }
    Plug 'rust-lang/rust.vim', { 'for': 'rust' }
    Plug 'scrooloose/nerdtree' | Plug 'jistr/vim-nerdtree-tabs'
    Plug 'sheerun/vim-polyglot'
    Plug 'SirVer/ultisnips'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-endwise'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-markdown', { 'for': 'markdown' }
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-sensible'
    Plug 'tpope/vim-sleuth'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-unimpaired'
    Plug 'vim-python/python-syntax'
    Plug 'wellle/targets.vim'
    Plug 'wellle/tmux-complete.vim'
    Plug 'wellle/visual-split.vim'

    Plug 'kana/vim-textobj-user' |
        \ Plug 'machakann/vim-textobj-delimited' |
        \ Plug 'coderifous/textobj-word-column.vim' |
        \ Plug 'bps/vim-textobj-python'
    Plug 'pangloss/vim-javascript', { 'for': ['html', 'javascript', 'vue'] }

    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' } |
        \ Plug 'junegunn/fzf.vim'
call plug#end()

filetype plugin indent on
filetype on
filetype plugin on
filetype indent on
syntax on


" }}}
" # Settings        =============================================== {{{
" _____________________________________________________________________________

try
    lang en_US.UTF-8  " default language for vim
catch
endtry

try
    set termguicolors  " support of true color
catch
    set t_Co=256 " use 256 colors
endtry

let &colorcolumn="80,120"                   " ruler for colorcolumn
set autoread                                " reread file if was changed outside
set breakindent                             " indent wrapped line
set breakindentopt=shift:2                  " how to indent wrapped line
set cmdheight=2                             " number of lines for commandline
set completeopt-=preview                    " no preview on autocomplete
set cursorline                              " use cursorline highlight
set eol                                     " always set end of the line at the end of the file
set expandtab                               " do not use tabs, spaces
set fcs=vert:│                              " solid line for veritcal separator
set ffs=unix,dos,mac                        " fileformats
set fileencodings=utf8,cp1251,koi8r,ucs-2le " list of encodings for 'fileencoding'
set fileencoding=utf8                       " character encoding for the buffer
set foldlevel=1                             " maximum level to be closed
set foldmethod=indent                       " default folding is indent
set foldnestmax=10                          " maximum nested folds
set formatprg=par                           " use par for paragraph formatting
set hidden                                  " set abandonned buffer as hidden
set history=1000                            " number of history entries to remember
set hlsearch                                " highlight search results
set ignorecase                              " required for smartcase
set lazyredraw                              " do not redraw screen on macro execution
set linebreak                               " use line breaks
set list                                    " show invisible characters
set modeline                                " read and respect vim modelines
set mouse=a                                 " enable normal mouse support
set mousehide                               " hide mouse pointer on editing
set nobackup                                " do not make backup of file we are updating
set noerrorbells                            " do not beep on errors
set nofoldenable                            " do not use folds by default
set nojoinspaces                            " do not insert 2 spaces after punctuation on line join
set noswapfile                              " do not use buffer swapfiles
set novisualbell                            " no visual bells on errors
set nowb                                    " do not make intermediate backups
set number                                  " show line numbers
set scrolloff=5                             " number of lines above cursor on scroll
set sessionoptions-=options                 " settings for sessions
set shiftwidth=4                            " length of tab
set shiftround                              " round indent to shiftwidth
set shortmess=I                             " do not show welcome page
set showbreak=↪                             " marker of wrapped line
set showcmd                                 " show the status of the current command in the status bar
set showmatch                               " show matching stuff (brackets, parens)
set showmode                                " show current active mode
set sidescroll=1                            " number of columns to scroll horizontally
set sidescrolloff=15                        " minimal number of columns to keep on left and right
set smartcase                               " use smartcase for searching
set smartindent                             " use auto indentation
set softtabstop=4                           " backspace unindent
set splitbelow                              " horizontal splits always below
set splitright                              " vertical split always on the right
set tabstop=4                               " indentation length of the tab
set termencoding=utf8                       " encoding of terminal
set timeoutlen=1000                         " how long to wait till next leader keypress
set timeout                                 " wait for following leader mapping
set ttimeout                                " how long to wait till next byte from terminal
set ttimeoutlen=1                           " wait 1 ms for next byte from terminal
set wildmenu                                " ex completion
set wildmode=full                           " default behavour

set statusline=%.80F                                   " filename
set statusline+=:%c,%l                                 " column and line number
set statusline+=\ %m%r                                 " modified and RO flags
set statusline+=%=                                     " switch to right side
set statusline+=%h%w                                   " show preview and help flags
set statusline+=\ [venv:%{pyenv#info#preset('short')}] " sdfsdf
set statusline+=[git:%{fugitive#head(7)}]              " git branch
set statusline+=%y                                     " filetype
set statusline+=\ %P                                   " percentage/position at file which is shown

set listchars=tab:▸\ ,trail:⋅,extends:❯,precedes:❮                             " how to display invisible charaters
set wildignore=*.o,*~,*.pyc,*.pyo,.git\*,.hg\*,svn\*,idea\*,__pycache__\*,.tox " do now show these in wildmenu

let g:python_host_prog  = $HOME . '/.neovim_pythons/2/bin/python'
let g:python3_host_prog = $HOME . '/.neovim_pythons/3/bin/python'

if has('nvim')
    runtime! python_setup.vim

    set inccommand=nosplit " make search/replace visually inplace
    set viminfo=           " with nvim we are going for shadas

    let g:terminal_color_0  = '#282828'
    let g:terminal_color_1  = '#cc241d'
    let g:terminal_color_2  = '#98971a'
    let g:terminal_color_3  = '#d79921'
    let g:terminal_color_4  = '#458588'
    let g:terminal_color_5  = '#b16286'
    let g:terminal_color_6  = '#689d6a'
    let g:terminal_color_7  = '#a89984'
    let g:terminal_color_8  = '#928374'
    let g:terminal_color_9  = '#fb4934'
    let g:terminal_color_10 = '#b8bb26'
    let g:terminal_color_11 = '#fabd2f'
    let g:terminal_color_12 = '#83a598'
    let g:terminal_color_13 = '#d3869b'
    let g:terminal_color_14 = '#8ec07c'
    let g:terminal_color_15 = '#ebdbb2'
    let g:terminal_scrollback_buffer_size = 10000
else
    set encoding=utf-8  " set encoding for vim
    set ttyfast         " fast terminal connection (not hw one)
    set ttymouse=xterm2 " type of mouse to use
endif

" some tmux magic to support italics
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif


" }}}
" # Colorscheme     =============================================== {{{
" _____________________________________________________________________________

let g:enable_bold_font          = 1
let g:gruvbox_contrast_dark     = "soft"
let g:gruvbox_italicize_strings = 1
let g:gruvbox_undercurl         = 1
let g:gruvbox_underline         = 1

if has('nvim')
    let g:gruvbox_italic = 1
endif

set background=dark
colorscheme gruvbox

hi StatusLine guibg=#7c6f64 guifg=#3c3836

" }}}
" # Autogroups      =============================================== {{{
" _____________________________________________________________________________


augroup Vim
    autocmd!
    autocmd VimResized             *            exe      "normal! \<c-w>="
    autocmd BufWritePre            *            :%s/\s\+$//e
    autocmd BufNewFile,BufReadPost *.md         set      filetype=markdown
    autocmd FileType               qf           setlocal colorcolumn=
    autocmd InsertLeave,WinEnter   *            set      cursorline
    autocmd InsertEnter,WinLeave   *            set      nocursorline
    autocmd FileType               vim          setlocal foldmethod=marker
    autocmd FileType               vim          setlocal foldlevel=0
    autocmd FileType               ansible,yaml setlocal ts=2 sw=2 sts=2 expandtab
    autocmd FileType               make         setlocal noexpandtab
augroup END

if has('nvim')
    augroup NeoVim
        autocmd!
        autocmd VimLeavePre,FocusLost           *        wshada
        autocmd VimEnter,CursorHold,FocusGained *        rshada
        autocmd BufEnter,WinEnter               term://* startinsert
        autocmd BufLeave                        term://* stopinsert
    augroup END
endif


" }}}
" # Keymap          =============================================== {{{
" _____________________________________________________________________________

let mapleader        = "\<Space>"
let g:mapleader      = "\<Space>"
let maplocalleader   = "\<Space>"
let g:maplocalleader = "\<Space>"

noremap  <up>    <nop>
noremap  <down>  <nop>
noremap  <left>  <nop>
noremap  <right> <nop>
inoremap <up>    <nop>
inoremap <down>  <nop>
inoremap <left>  <nop>
inoremap <right> <nop>

nnoremap <silent> <leader>w :update<cr>
cnoremap w!! w !sudo tee > /dev/null %

nnoremap / /\v
vnoremap / /\v
cnoremap %s/ %smagic/
cnoremap \>s/ \>smagic/
nnoremap :g/ :g/\v
nnoremap :g// :g//

vnoremap < <gv
vnoremap > >gv

nnoremap j gj
nnoremap k gk
nnoremap $ g$
nnoremap 0 ^

nnoremap <silent> n  nzz
nnoremap <silent> N  Nzz
nnoremap <silent> *  *zz
nnoremap <silent> #  #zz
nnoremap <silent> g* g*zz
nnoremap <silent> g# g#zz

nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap <C-f> <C-f>zz
nnoremap <C-b> <C-b>zz

nnoremap <C-h>    <C-w>h
nnoremap <C-j>    <C-w>j
nnoremap <C-k>    <C-w>k
nnoremap <C-l>    <C-w>l
nnoremap <silent> <C-x> :resize<cr>:vertical resize<cr>

nnoremap <leader>bd :Bdelete<cr>

nnoremap <silent> <Leader>1 1gt<cr>
nnoremap <silent> <Leader>2 2gt<cr>
nnoremap <silent> <Leader>3 3gt<cr>
nnoremap <silent> <Leader>4 4gt<cr>
nnoremap <silent> <Leader>5 5gt<cr>
nnoremap <silent> <Leader>6 6gt<cr>
nnoremap <silent> <Leader>7 7gt<cr>
nnoremap <silent> <Leader>8 8gt<cr>
nnoremap <silent> <Leader>9 9gt<cr>

nnoremap * *``
nnoremap <silent> <Leader>q :call <SID>QuickfixToggle()<cr>
nnoremap <silent> <Leader>l :call <SID>LocalfixToggle()<cr>
nnoremap <silent> <Leader>qq :q<cr>
nnoremap <silent> <Leader>qa :qa<cr>
nnoremap <Leader>gp :Grep<space>
inoremap jk <esc>
vnoremap <silent> s :!sort<cr>
inoremap # X<BS>#

noremap <silent><F12> <Esc>:syntax sync fromstart<CR>


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

let g:localfix_is_open = 0
function! s:LocalfixToggle()
    if g:localfix_is_open
        cclose
        lclose
        let g:localfix_is_open = 0
        execute g:localfix_return_to_window . "wincmd w"
      else
        let g:localfix_return_to_window = winnr()
        lopen
        let g:localfix_is_open = 1
    endif
endfunction

" _____________________________________________________________________________

if has('nvim')
    tnoremap <A-h> <C-\><C-n><C-w>h
    tnoremap <A-j> <C-\><C-n><C-w>j
    tnoremap <A-k> <C-\><C-n><C-w>k
    tnoremap <A-l> <C-\><C-n><C-w>l
    nnoremap <A-h> <C-w>h
    nnoremap <A-j> <C-w>j
    nnoremap <A-k> <C-w>k
    nnoremap <A-l> <C-w>l
    tnoremap <A-q> <C-\><C-n>
    tnoremap <A-]> <C-\><C-n>:q!<cr>

    highlight TermCursor ctermfg=gray guifg=gray

    nnoremap <silent> <leader>] :vsplit term://$SHELL<cr>
    nnoremap <silent> <leader>[ :split term://$SHELL<cr>
endif


" }}}
" # Plugin settings =============================================== {{{
" _____________________________________________________________________________

" VimGo {{{

let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods   = 1
let g:go_highlight_structs   = 1

let g:go_bin_path = expand("~/.gotools")
let g:go_auto_type_info = 1

augroup Go
    autocmd!
    autocmd FileType go nmap <leader>gcs <Plug>(go-doc)
    autocmd FileType go nmap <leader>gcv <Plug>(go-doc-vertical)
    autocmd FileType go nmap <leader>gdt <Plug>(go-def-tab)
    autocmd FileType go nmap <leader>gds <Plug>(go-def-split)
    autocmd FileType go nmap <leader>gdv <Plug>(go-def-vertical)
    autocmd FileType go nmap <leader>gl  <Plug>(go-callers)
    autocmd FileType go nmap <leader>gi  <Plug>(go-implements)
    autocmd FileType go nmap <leader>gm  <Plug>(go-imports)
    autocmd FileType go nmap <leader>gr  <Plug>(go-rename)
augroup END

" }}}
" NerdTree and NerdTreeTabs {{{

let g:nerdtree_tabs_open_on_gui_startup     = 0
let g:nerdtree_tabs_open_on_console_startup = 0

let NERDTreeIgnore = ['\.py[co]$', '__pycache__']

map <silent> <F2> :NERDTreeTabsToggle<CR>
map <silent> <F3> :NERDTreeFind<CR>

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
let g:UltiSnipsUsePythonVersion   = 3

" }}}
" Signify {{{

let g:signify_vcs_list           = [ 'git' ]
let g:signify_update_on_bufenter = 1

" }}}
" Ale {{{

let g:airline#extensions#ale#enabled = 0
let g:ale_lint_on_insert_leave = 1
let g:ale_linters = {
  \ 'python':     ['flake8'],
  \ 'sh':         ['shellcheck'],
  \ 'go':         ['gometalinter'],
  \ 'javascript': ['eslint'],
  \ 'vue':        ['eslint'],
  \ 'yaml':       ['yamllint'],
  \ 'scss':       ['sasslint'],
  \ 'sass':       ['sasslint'],
  \ 'markdown':   ['markdownlint', 'writegood'],
  \ 'rst':        ['rstcheck', 'writegood']
\}
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'
let g:ale_sign_column_always = 1

" }}}
" FZF {{{

nnoremap <silent> <leader>ff :Files<cr>
nnoremap <silent> <leader>fb :Buffers<cr>
nnoremap <silent> <leader>ft :Tags<cr>
nnoremap <silent> <leader>fl :Lines<cr>
nnoremap <silent> <leader>fm :Marks<cr>
nnoremap <silent> <leader>fa :Ag<cr>
nnoremap <silent> <leader>fg :GFiles?<cr>

" }}}
" Gutentags {{{

let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_new = 1
let g:gutentags_ctags_exclude = [
    \ '*.min.js',
    \ '*html*',
    \ 'jquery*.js',
    \ 'node_modules',
    \ '*.pyc',
    \ '*.pyo',
    \ '.tox',
    \ ]

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
" Deoplete {{{

if has('nvim')
    let g:deoplete#enable_at_startup          = 1
    let g:deoplete#max_list                   = 20
    let g:deoplete#auto_complete_start_length = 3

    let g:deoplete#sources#go#gocode_binary = expand("~/.gotools/gocode")
    let g:deoplete#sources#go#use_cache = 1

    inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ deoplete#mappings#manual_complete()
    inoremap <silent><expr> <S-TAB>
        \ pumvisible() ? "\<C-p>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ deoplete#mappings#manual_complete()

    function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~ '\s'
    endfunction

    call deoplete#custom#set('_', 'matchers', ['matcher_fuzzy'])
endif

" }}}
" Jedi {{{

let g:jedi#completions_enabled   = 0
let g:jedi#goto_command          = "<leader>yg"
let g:jedi#documentation_command = "<leader>yd"
let g:jedi#usages_command        = "<leader>yr"
let g:jedi#rename_command        = "<leader>yn"

" }}}
" Easy Align {{{

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" }}}
" Sneak {{{

let g:sneak#streak     = 1
let g:sneak#use_ic_scs = 1

" }}}
" Polyglot {{{

let g:polyglot_disabled = ["python"]

" }}}
" vim-python {{{

let g:python_highlight_all = 1

" }}}
" vim-javascript {{{

let g:javascript_plugin_flow = 1

" }}}

" }}}
