" __init__.vim

let s:windows = has('win32') || has('win64') || has('win95') || has('win16')

if s:windows && has('gui_running') && has('nvim') == 0
    " remove italic for GVim
    call cpatch#disable_italic()
endif
