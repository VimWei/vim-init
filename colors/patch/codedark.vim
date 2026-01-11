" 设置选中标签页背景色
hi TabLineSel gui=bold term=bold cterm=bold guifg=#D4D4D4 guibg=#1E1E1E
" 设置链接文本样式
hi! link markdownLinkText Underlined
" 设置链接地址样式
hi! link markdownUrl None
" 取消折叠文本的下划线，并设置与背景色形成比对的颜色
hi Folded gui=NONE term=NONE cterm=NONE guifg=#569CD6 ctermfg=65
