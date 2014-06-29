" Different things for coding

" Enable filetype related settings
filetype on
filetype plugin on
filetype indent on

" Enable syntax
syntax on

" Set relative numbers
set relativenumber

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

" Set color scheme
try
    colorscheme desert
    let g:colors_name="desert"
catch
endtry

set background=dark
highlight ColorColumn ctermbg=235 guibg=#2c2d27

" Set line breaks
set lbr
set tw=500

" Setup folding
set foldmethod=indent
set foldnestmax=10
set foldlevel=1
set nofoldenable
