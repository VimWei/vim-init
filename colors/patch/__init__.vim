" __init__.vim - color patch initialize

let s:windows = has('win32') || has('win64') || has('win95') || has('win16')

" Windows GVim Patch -----------------------------------------------------{{{1

if s:windows && has('gui_running') && has('nvim') == 0
    " remove italic for GVim
    if get(g:, 'color_enable_italic', 0) == 0
        call asclib#style#remove_style('italic')
    endif
endif
