" 修改 markdown 标题的样式
for i in range(1, 6)
    execute 'highlight markdownH' . i . ' cterm=bold gui=bold'
endfor

" 设置选中标签页背景色
hi TabLineSel guifg=#000000 guibg=darkgrey gui=bold cterm=bold

" 去除非选中标签页背景色
hi TabLine guifg=#666666 guibg=NONE gui=NONE cterm=NONE
