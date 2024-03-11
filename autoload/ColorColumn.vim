" 手工设置ColorColumn
" :set cc=78

" 切换显示当前所在位置的对齐线
function! ColorColumn#ColorColumnSet()
    let col_num = virtcol(".")
    let cc_list = split(&cc, ',')
    if count(cc_list, string(col_num)) <= 0
        execute "set cc+=".col_num
    else
        execute "set cc-=".col_num
    endif
endfunction

" 高亮 'textwidth' 之后的列
function! ColorColumn#ColorColumnTextwidth()
    set cc=79
endfunction

" 取消全部ColorColumn
function! ColorColumn#ColorColumnRemoveAll()
    set cc=
endfunction
