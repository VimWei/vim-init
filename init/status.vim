" statusline --------------------------------------------------------------{{{1
set laststatus=2                                " 总是显示状态栏
set statusline=                                 " 清空状态
let g:status_padding_left = "  "
set statusline+=%{''.g:status_padding_left}     " left padding
set statusline+=\[b%n                           " buffer编号
set statusline+=\%R%H]                          " 是否只读或帮助文档
set statusline+=\ %f                            " 文件名(相对路径)
set statusline+=\ %m                            " 编辑状态
set statusline+=\ %{''.toupper(mode())}         " INSERT/NORMAL/VISUAL
set statusline+=%=                              " 向右对齐
set statusline+=\ %y                            " 文件类型
" 最右边显示文件编码和行号等信息，并且固定在一个 group 中，优先占位
set statusline+=\ %0(%{&fileformat}\ [%{(&fenc==\"\"?&enc:&fenc).(&bomb?\",BOM\":\"\")}]\ %v:%l/%L=%p%%%)
let g:status_padding_right = " "
set statusline+=%{''.g:status_padding_right}    " right padding
