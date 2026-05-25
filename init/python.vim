"===================================================
" Python provider settings
" Sourced by: ../init.vim
"===================================================

" 不再硬编码 g:python_venv_prog
" python#Provider() 会通过 python#Detect() 动态探测 Python 路径

" Load Python provider ---------------------------------------------------{{{1
" Explicitly source to avoid autoload resolution issues during startup
execute 'source ' . g:viminit . 'autoload/python.vim'

" Set available early so plugins load correctly
let g:python_available = v:true

" Defer DLL setup to avoid GUI flash and speed up startup
augroup PythonProviderSetup
    autocmd!
    autocmd VimEnter * call python#SetupDLL()
augroup END
