highlight NonText    gui=none guifg=#707070 guibg=bg

" 改进浮动窗口选中行的可见性
" 设置弹出菜单/浮动窗口背景色（浅灰色，与白色背景有明显区别）
highlight Pmenu      gui=none guifg=#000000 guibg=#f0f0f0 ctermbg=green ctermfg=white
" 设置选中项背景色（深蓝色，与背景形成强烈对比）
highlight PmenuSel   gui=none guifg=#ffffff guibg=#4570aa ctermbg=white ctermfg=black
" 设置滚动条样式
highlight PmenuSBar  gui=none guifg=#ffffff guibg=#d0d0d0 ctermbg=red ctermfg=white
highlight PmenuThumb gui=none guifg=#4570aa guibg=#ffffff ctermbg=white ctermfg=red
" Neovim 浮动窗口相关设置
highlight NormalFloat gui=none guifg=#000000 guibg=#f0f0f0
highlight FloatBorder gui=none guifg=#6b6b6b guibg=#f0f0f0

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

finish
if !has('gui_running')
    set t_Co=256
    call Color#convert_gui_color()
endif
