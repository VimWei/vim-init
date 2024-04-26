" 修改 markdown 标题的样式
for i in range(1, 6)
    execute 'highlight markdownH' . i . ' cterm=bold gui=bold'
endfor

finish

if &background ==# 'dark'
    " 选中标签页
    " hi TabLineSel guifg=#000000 guibg=#dadada gui=bold cterm=bold
    hi TabLineSel guifg=#000000 guibg=#dadada gui=reverse cterm=reverse
    " 非选中标签页
    " hi TabLine guifg=#707070 guibg=#000000 gui=reverse cterm=reverse
    hi TabLine guifg=#000000 guibg=#a8a8a8 gui=NONE cterm=NONE
    " 标签页填充区
    " hi TabLineFill guifg=#dadada guibg=NONE gui=NONE cterm=NONE
    hi TabLineFill guifg=#000000 guibg=#d7d7d7 gui=NONE cterm=NONE
else
    "选中标签页
    " hi TabLineSel guifg=#eeeeee guibg=#000000 gui=bold cterm=bold
    hi TabLineSel guifg=#000000 guibg=#dadada gui=reverse cterm=reverse
    "非选中标签页
    hi TabLine guifg=#000000 guibg=#a8a8a8 gui=NONE cterm=NONE
    " 标签页填充区
    hi TabLineFill guifg=#000000 guibg=#d7d7d7 gui=NONE cterm=NONE
endif
