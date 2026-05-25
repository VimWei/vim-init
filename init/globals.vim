" globals.vim - Global variables and runtime setup
" Sourced by init.vim, depends on g:viminit

" runtimepath / packpath ------------------------------------------------{{{1
execute 'set runtimepath+=' . g:viminit
execute 'set runtimepath+=' . g:viminit . 'after'
execute 'set packpath+=' . g:viminit
let g:viminitparent = fnamemodify(g:viminit, ':h:h') . '/'
let g:plugin_config_path = g:viminit . 'plugin-config/'

" g:vim_data_dir ---------------------------------------------------------{{{1
" 将运行时数据（插件、swap、backup、undo）与配置文件(.config/vim)物理隔离
if has('win32') || has('win64')
    let g:vim_data_dir = expand('~/vimfiles')
else
    let g:vim_data_dir = expand('~/.vim')
endif
let g:vim_data_dir = substitute(g:vim_data_dir, '\\', '/', 'g')
if g:vim_data_dir !~ '/$'
    let g:vim_data_dir = g:vim_data_dir . '/'
endif

" 隔离运行时目录，不污染 .config/vim 仓库 ------------------------------{{{1
for s:dir in [g:vim_data_dir . 'backup', g:vim_data_dir . 'swap']
    if !isdirectory(s:dir)
        call mkdir(s:dir, 'p', 0700)
    endif
endfor
let &backupdir = g:vim_data_dir . 'backup//'
let &directory  = g:vim_data_dir . 'swap//'
