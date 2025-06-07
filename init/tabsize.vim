"===================================================
" Tabsize settings by W.Chen
" Sourced by: ../init.vim
"===================================================

set tabstop=4       " 制表符显示为 4 空格
set softtabstop=4   " 插入模式按 Tab 插入 4 空格
set shiftwidth=4    " 缩进操作使用 4 空格
set shiftround      " 强制缩进量对齐到 shiftwidth 的整数倍
set expandtab       " 强制 Tab 转为空格，若需替换已有文件则%retab!
set smarttab        " 智能区分行首/非行首Tab：行首插入 shiftwidth 空格；非行首插入 softtabstop 空格
set autoindent      " 新行自动复制上一行的缩进模式（空格或制表符）
" set cindent         " 打开 C/C++ 语言缩进优化`
