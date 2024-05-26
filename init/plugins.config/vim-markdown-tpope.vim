" https://www.github.com/tpope/vim-markdown
" :help ft-markdown-plugin

" g:markdown_folding -----------------------------------------------------{{{1

let g:markdown_folding = 1

" set filetype markdown --------------------------------------------------{{{1

" 将文档类型设置为markdown
nnoremap <leader>mm :set ft=markdown<CR>

" 设置新建文档类型为 markdown，从而可以对 list 使用 gqip 格式化命令
augroup NewBufferFiletype
    autocmd!
    " 避免将 terminal 设置为 markdown
    autocmd BufEnter * call timer_start(1, 'CheckAndSetFiletype')
augroup END
function! CheckAndSetFiletype(timer_id)
    " 避免设置刚启动的页面为 markdown，否则启动画面将消失
    if &buftype == '' && &filetype == '' && @% == '' && bufnr('%') != 1
        setlocal filetype=markdown
    endif
endfunction

" MarkdownLinkConceal ----------------------------------------------------{{{1
" 自动隐藏 markdown 链接
" src: https://github.com/jakewvincent/mkdnflow.nvim/commits/main/lua/mkdnflow/conceal.lua
" 解决Mistook todo checkbox as markdown link，要将修订版放在 ~vimfiles/syntax/markdown.vim
" src: https://github.com/tpope/vim-markdown/issues/212
augroup MarkdownLinkConceal
    autocmd!
    autocmd FileType markdown
        \ syn region markdownLink matchgroup=markdownLinkDelimiter
        \ start="(" end=")" contains=markdownUrl keepend contained conceal
    autocmd FileType markdown
        \ syn region markdownLinkText matchgroup=markdownLinkTextDelimiter
        \ start="!\=\[\%(\_[^][]*\%(\[\_[^][]*\]\_[^][]*\)*]\%([[(]\)\)\@="
        \ end="\]\%([[(]\)\@=" nextgroup=markdownLink,markdownId skipwhite
        \ contains=@markdownInline,markdownLineStart concealends
augroup END

" set markdown format ----------------------------------------------------{{{1

" 为选中的Markdown文字加粗，bold
nnoremap <leader>mb viW"ms****<Esc>h"mPe
vnoremap <leader>mb "ms****<Esc>h"mPe
" 为选中的Markdown文字转为斜体，italic
nnoremap <leader>mi viW"ms____<Esc>h"mPe
vnoremap <leader>mi "ms____<Esc>h"mPe
" 为选中的内容添加链接，link
nnoremap <leader>ml viW<ESC>`>a]()<ESC>`<i[<ESC>`>4l
vnoremap <leader>ml <ESC>`>a]()<ESC>`<i[<ESC>`>4l
" 删除光标所在处的链接，link delete
nnoremap <leader>mld F[xf]xda(
" 为选中的内容添加图片链接，picture
nnoremap <leader>mp viW<ESC>`>a]()<ESC>`<i![<ESC>`>5l
vnoremap <leader>mp <ESC>`>a]()<ESC>`<i![<ESC>`>5l
" 删除光标所在处的图片链接，picture delete
nnoremap <leader>mpd F[h2xf]xda(

" UngqFormat -------------------------------------------------------------{{{1
" 详情查阅 ../../autoload/Markdown.vim

" 恢复被 gq 格式化的文档格式
" :UngqFormat：处理整个文件。
" :'<,'>UngqFormat：处理当前选区。
command! -range=% UngqFormat call Markdown#UngqFormat(<line1>, <line2>)
