" 去除非选中标签页的下划线
highlight TabLine gui=NONE term=NONE cterm=NONE guifg=#000000 guibg=DarkGrey ctermfg=NONE ctermbg=248
" 去除标签页填充区的颜色
highlight TabLineFill gui=NONE term=NONE cterm=NONE guifg=NONE guibg=DarkGrey ctermfg=NONE ctermbg=248

" 修改 markdown 标题的样式
for i in range(1, 6)
    execute 'highlight markdownH' . i . ' ctermfg=Yellow guifg=Yellow cterm=bold gui=bold'
endfor
