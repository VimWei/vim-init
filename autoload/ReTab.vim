" Tab与空格互换

function! ReTab#Tab2Space()
    set tabstop=4       " 制表符显示为 4 空格
    set softtabstop=4   " 插入模式按 Tab 插入 4 空格
    set shiftwidth=4    " 缩进操作使用 4 空格
    set expandtab
    %retab!
endfunc
function! ReTab#Space2Tab()
    set tabstop=4       " 制表符显示为 4 空格
    set softtabstop=4   " 插入模式按 Tab 插入 4 空格
    set shiftwidth=4    " 缩进操作使用 4 空格
    set noexpandtab
    %retab!
endfunc
