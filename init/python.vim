"===================================================
" Python provider settings
" Sourced by: ../init.vim
"===================================================

" 记录项目 venv 的 python 路径，供内部插件（如 PinYin）使用
" 注意：不设置 $VIRTUAL_ENV，以免污染用户其他项目的 uv 环境
let g:python_venv_prog = g:viminit . '.venv/Scripts/python.exe'

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
