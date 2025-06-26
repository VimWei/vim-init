" https://www.github.com/tpope/vim-markdown
" :help ft-markdown-plugin

" default setting --------------------------------------------------------{{{1
let g:markdown_folding = 1
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']
let g:markdown_minlines = 50

finish " -----------------------------------------------------------------{{{1

" set markdown format ----------------------------------------------------{{{1
" 为选中的内容添加链接，link
nnoremap <leader>ml viW<ESC>`>a]()<ESC>`<i[<ESC>`>4l
vnoremap <leader>ml <ESC>`>a]()<ESC>`<i[<ESC>`>4l
" 为选中的内容添加图片链接，picture
nnoremap <leader>mp viW<ESC>`>a]()<ESC>`<i![<ESC>`>5l
vnoremap <leader>mp <ESC>`>a]()<ESC>`<i![<ESC>`>5l

" 删除光标所在处的链接或图片链接，link picture remove
" 详情查阅 ../../autoload/Markdown.vim
nnoremap <leader>mlr :call Markdown#RemoveLinkAtCursor()<CR>

" UngqFormat -------------------------------------------------------------{{{1
" 详情查阅 ../../autoload/Markdown.vim

" 恢复被 gq 格式化的文档格式
" :UngqFormat：处理整个文件。
" :'<,'>UngqFormat：处理当前选区。
command! -range=% UngqFormat call Markdown#UngqFormat(<line1>, <line2>)
