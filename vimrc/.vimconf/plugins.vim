" Settings for Vundle

set nocompatible
filetype off

set runtimepath+=~/.vim/bundle/neobundle.vim/

" Required for vimproc
let g:make = 'gmake'
if system('uname -o') =~ '^GNU/'
    let g:make = 'make'
endif

call neobundle#begin(expand('~/.vim/bundle'))
    NeoBundleFetch 'Shougo/neobundle.vim'

    NeoBundle 'altercation/vim-colors-solarized'
    NeoBundle 'bling/vim-airline'
    NeoBundle 'Shougo/unite.vim'
    NeoBundle 'Shougo/neomru.vim'
    NeoBundle 'fatih/vim-go'
    NeoBundle 'gmarik/vundle'
    NeoBundle 'hynek/vim-python-pep8-indent'
    NeoBundle 'kien/rainbow_parentheses.vim'
    NeoBundle 'Lokaltog/vim-easymotion'
    NeoBundle 'terryma/vim-expand-region'
    NeoBundle 'terryma/vim-multiple-cursors'
    NeoBundle 'scrooloose/nerdtree'
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


" Different settings for plugins

" Smooth scrolling
if has('gui_running')
    noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<cr>
    noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<cr>
    noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<cr>
    noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<cr>

    set guifont=Meslo\ LG\ M\ DZ\ for\ Powerline\ 11
endif

" " YouCompleteMe settings
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_add_preview_to_completeopt = 0
nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<cr>

" Setup statusline airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme="solarized"

"Solarized color scheme
set t_Co=256
set background=dark
let g:solarized_contrast="normal"
let g:solarized_visibility="normal"
colorscheme solarized

" Ignore some folders and files for CtrlP indexing
" let g:ctrlp_custom_ignore = {
"   \ 'dir':  '\.git$\|\.yardoc\|public$|log\|tmp$',
"   \ 'file': '\.so$\|\.dat$|\.DS_Store$'
"   \ }

" Use AG for CtrlP search
" https://github.com/ggreer/the_silver_searcher
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--nocolor --nogroup --column'
    let g:unite_source_grep_recursive_opt = ''
    " let g:ctrlp_user_command = 'ag %s -lSf --nocolor -g ""'
    " let g:ctrlp_use_caching = 0
endif

map <F2> :NERDTreeToggle<CR>

let g:unite_source_rec_async_command= 'ag --nocolor --nogroup --hidden -g ""'
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

" Rainbow parenthesis
au VimEnter * RainbowParenthesesToggleAll
au Syntax   * RainbowParenthesesLoadRound
au Syntax   * RainbowParenthesesLoadSquare
au Syntax   * RainbowParenthesesLoadBraces
