"===================================================
" Essential settings by W.Chen
" Sourced by: ../init.vim
"===================================================

" Basic Setting -----------------------------------------------------------{{{1
set nocompatible    "启用不兼容Vi模式
set ttimeout    "启用功能键超时检测
set ttimeoutlen=50
if has('autocmd')
    filetype plugin indent on   "允许Vim自带脚本根据文件类型自动设置缩进等
endif
if has('syntax')
    syntax enable   "启用语法高亮，且更改颜色方案时自动更新语法高亮的颜色
    syntax on   "启用语法高亮，且仅在执行命令时设置一次，之后就不会再改变
endif

" Encoding related --------------------------------------------------------{{{1
if has('multi_byte')
    set encoding=utf-8  "Vim 内部工作编码
    set fileencoding=utf-8  "设置此缓冲区所在文件的字符编码；新文件默认编码
    " 打开文件时自动尝试下面顺序的编码
    set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
endif
" set ambiwidth=double    "使用US-ASCII字符两倍的宽度显示宽度不明的字符
set nobomb    "取消UTF的BOMB文件头
set ffs=unix,dos,mac    " 文件换行符，默认使用 unix 换行符
if !has('nvim')
    set cryptmethod=blowfish2    "设置新的加密算法
endif

" Display related ---------------------------------------------------------{{{1
source $VIMRUNTIME/delmenu.vim
set langmenu=zh_CN.UTF-8    "指定菜单语言，若需要英文则none
source $VIMRUNTIME/menu.vim
language message en_US.ISO_8859-1 "指定提示信息语言
" language message zh_CN.UTF-8    "指定提示信息语言
set helplang=cn "帮助语言首选中文版，可通过@en切换为英文
set scrolloff=0 "光标移动到buffer的顶部和底部时保持u行距离
set number  "在每行前面显示行号
set relativenumber  "显示相对于光标所在的行的行号
set ruler   "总在Vim窗口的右下角显示当前光标位置
set cursorline  "高亮光标所在的屏幕行
set showcmd "在Vim窗口右下角，标尺的右边显示未完成的命令
set display=lastline    "窗口末行内容较多时，尽量显示内容而非@@@
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<     "设置分隔符可视

" Format related ----------------------------------------------------------{{{1
set textwidth=0    "光标超过指定列的时候折行
set wrap    "自动折行，超过窗口宽度的行会回绕，并在下一行继续显示
set wrapmargin=0    "确保 Vim 不会基于窗口宽度减去 wrapmargin 的值来自动折行
set linebreak   "不在单词中间断行
set errorformat+=[%f:%l]\ ->\ %m,[%f:%l]:%m     "错误格式

" 让新建页面也能正常处理 lists 和 gq 格式化
set formatoptions+=m    "如遇Unicode值大于255的文本，不必等到空格再折行
set formatoptions+=B    "合并两行中文时，不在中间加空格
set formatoptions+=n    "在格式化列表时尝试保持相同的编号或项目符号
" set comments=b:*,b:-,b:+ " *-+ 是可以格式化的项目符号
set formatlistpat=^\\s*\\%(\\(-\\\|\\*\\\|+\\)\\\|\\(\\C\\%(\\d\\+\\.\\)\\)\\)\\s\\+\\%(\\[\\([\ .oOX-]\\)\\]\\s\\)\\?

" 对新建文档，设置格式化选项
augroup Newfile_settings
    autocmd!
    autocmd BufEnter * if empty(&filetype)
        \ | setlocal autoindent
        \ | setlocal nosmartindent
        \ | setlocal nocindent
        \ | setlocal comments=""
        \ | setlocal formatoptions-=c
        \ | setlocal formatoptions-=r
        \ | setlocal formatoptions-=o
        \ | setlocal formatoptions-=2
        \ | setlocal formatoptions+=n
        \ | endif
augroup END

" 进入 wiki 后，让 pwd 转到 wiki_root
" augroup wiki_vim_autochdir
"     autocmd!
"     autocmd BufEnter *.md,*.wiki if getbufvar(expand('%'), '&filetype') == 'markdown' | execute 'cd ' . g:wiki_root | endif
" augroup END

" 解决自定义 ftplugin/markdown.vim 与 plugged/vim-markdown 冲突
" augroup markdown_customizations
"     autocmd!
"     autocmd FileType markdown setlocal formatoptions-=r
"     autocmd FileType markdown setlocal comments=""
" augroup END

" Editing related ---------------------------------------------------------{{{1
set history=1000    "命令历史的保存数量
set clipboard=unnamed   "与系统共享剪贴板
set nrformats-=octal    "CTRL-A增CTRL-X减数字时，以十进制处理0开头的数字
" 允许在自动缩进、换行符、插入开始的位置上退格
set backspace=indent,eol,start
" 对某一个或几个按键开启到头后自动折向下一行的功能
set whichwrap=b,s,<,>,[,]
set wildmenu    "命令行补全时，使用增强的单行菜单形式显示补全内容
set browsedir=buffer    "浏览启动目录使用当前缓冲区所在目录
set autoread    "自动重新读入被修改的文件
set mouse=a "在所有模式下允许使用鼠标
set mousemodel=popup    "右击鼠标时，会显示一个上下文菜单
set selectmode= "不使用选择模式
set keymodel=   "不使用“Shift + 方向键”选择文本
set selection=inclusive "指定在选择文本时，光标所在位置也属于被选中的范围
