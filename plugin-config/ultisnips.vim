" https://github.com/SirVer/ultisnips

" 配置 -------------------------------------------------------------------{{{1

let g:UltiSnipsEditSplit="vertical"

" 避免与vim-auto-popmenu、YouCompleteMe、completion-nvim的<tab>冲突
" let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsListSnippets="<C-tab>"
let g:UltiSnipsJumpForwardTrigger="<C-f>"
let g:UltiSnipsJumpBackwardTrigger="<C-b>"

" 设置snippets存放目录 ---------------------------------------------------{{{1
" 自定义的存放目录，可以多个
let g:my_snippet_dirs = [g:viminit . '/tools/UltiSnips']
" 自动创建缺失目录
for dir in g:my_snippet_dirs
    if !isdirectory(expand(dir))
        call mkdir(expand(dir), 'p')
    endif
endfor
" 保留插件自带snippets（如UltiSnips）的同时，添加自定义目录
" let g:UltiSnipsSnippetDirectories = ['UltiSnips'] + g:my_snippet_dirs
let g:UltiSnipsSnippetDirectories = g:my_snippet_dirs

" 快捷访问存放目录
nnoremap <leader>us :execute 'Lexplore ' . g:my_snippet_dirs[0]<CR>
