" 修改 markdown 标题的样式
for i in range(1, 6)
    execute 'highlight markdownH' . i . ' cterm=bold gui=bold'
endfor

" 设置链接文本样式
hi! markdownLinkText guifg=#c3e88d ctermfg=2 gui=Underline

" 设置链接地址样式
hi! markdownUrl guifg=#f07178 ctermfg=204 gui=None
