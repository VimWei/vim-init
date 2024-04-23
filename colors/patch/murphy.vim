" 选中标签页
hi TabLineSel guifg=#87ff87 guibg=#000000 gui=bold cterm=bold
" 非选中标签页
hi TabLine guifg=#ffffff guibg=#444444 gui=NONE cterm=NONE

finish

if &background ==# 'dark'
    " 选中标签页
    hi TabLineSel guifg=#000000 guibg=#dadada gui=bold cterm=bold
    " hi TabLineSel guifg=#000000 guibg=darkgrey gui=bold cterm=bold
    " 非选中标签页
    hi TabLine guifg=#707070 guibg=#000000 gui=reverse cterm=reverse
    " hi TabLine guifg=#666666 guibg=NONE gui=NONE cterm=NONE
else
    " 选中标签页
    hi TabLineSel guifg=#eeeeee guibg=#000000 gui=bold cterm=bold
    " hi TabLineSel guifg=#000000 guibg=darkgrey gui=bold cterm=bold
    " 非选中标签页
    hi TabLine guifg=#000000 guibg=#a8a8a8 gui=NONE cterm=NONE
    " hi TabLine guifg=#666666 guibg=NONE gui=NONE cterm=NONE
endif
