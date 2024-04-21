" 修改 markdown 标题的样式
for i in range(1, 6)
    execute 'highlight markdownH' . i . ' cterm=bold gui=bold'
endfor
