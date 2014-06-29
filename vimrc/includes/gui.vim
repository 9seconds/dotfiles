" Different settings for GUI

if has("gui_running")
    set guioptions-=T  " hide toolbar
    set guioptions-=r  " hide right scrollbar
    set guioptions-=L  " hide left scrollbar
    set guioptions-=m  " hide menu bar

    " Always fullscreen
    set lines=999
    set columns=999

    set guitablabel=%M\ %t
endif
