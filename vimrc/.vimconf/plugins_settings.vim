" Different settings for plugins

" Smooth scrolling
if has('gui_running')
    noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<cr>
    noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<cr>
    noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<cr>
    noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<cr>

    set guifont=Meslo\ LG\ M\ DZ\ for\ Powerline\ 11
endif

" YouCompleteMe settings
let g:ycm_autoclose_preview_window_after_completion=1
nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<cr>

" Setup statusline airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

"Solarized color scheme
set t_Co=256
let g:solarized_contrast="normal"
let g:solarized_visibility="normal"

colorscheme solarized
if has("gui_running")
    set background=light
else
    set background=dark
endif

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

" Rainbow parenthesis
au VimEnter * RainbowParenthesesToggleAll
au Syntax   * RainbowParenthesesLoadRound
au Syntax   * RainbowParenthesesLoadSquare
au Syntax   * RainbowParenthesesLoadBraces

nnoremap <silent> <F11> :YRShow<CR>
