" This is a common settings for VIM

" Remove compatibility with VIM
set nocompatible

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
set autowrite

" Turn on WildMenu
set wildmenu
set wildignore=*.o,*~,*.pyc,*.pyo,.git\*,.hg\*,svn\*

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

" Specify the behavior when switching between buffers
try
    set switchbuf=useopen,usetab,newtab
    set stal=2
catch
endtry

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

" Resize splits if the window is resized
au VimResized * exe "normal! \<c-w>="

" Remote trailing whitespaces on save
autocmd BufWritePre * :%s/\s\+$//e
