highlight NonText    gui=none guifg=#707070 guibg=bg

if !has('gui_running')
	set t_Co=256
	call module#colors#convert_gui_color()
endif

" 去除非选中标签页的下划线
highlight TabLine gui=NONE term=NONE cterm=NONE guifg=NONE guibg=DarkGrey ctermfg=NONE ctermbg=248
" 去除标签页填充区的颜色
highlight TabLineFill gui=NONE term=NONE cterm=NONE guifg=NONE guibg=DarkGrey ctermfg=NONE ctermbg=248
" 设置选中标签页背景色
hi TabLineSel gui=bold term=bold cterm=bold guifg=NONE guibg=#e5e5e5

" 设置链接文本样式
hi! link markdownLinkText Underlined
highlight Underlined gui=underline guifg=blue    guibg=bg
" 设置链接地址样式
hi! link markdownUrl None
