if !has('gui_running')
    hi Normal ctermbg=NONE
    hi LineNr ctermbg=NONE
    hi SignColumn ctermbg=NONE
    highlight! LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE
        \ gui=NONE guifg=#585858 guibg=NONE
endif

" 设置链接文本样式
hi! link markdownLinkText Underlined
" 设置链接地址样式
hi! link markdownUrl None
" 修改 markdown 标题的样式
for i in range(1, 6)
    execute 'highlight markdownH' . i . ' cterm=bold gui=bold'
endfor
