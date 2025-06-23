" https://www.github.com/tpope/vim-markdown
" :help ft-markdown-plugin

" default setting --------------------------------------------------------{{{1
let g:markdown_folding = 1
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']
let g:markdown_minlines = 50

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
" 为选中的内容添加图片链接，picture
nnoremap <leader>mp viW<ESC>`>a]()<ESC>`<i![<ESC>`>5l
vnoremap <leader>mp <ESC>`>a]()<ESC>`<i![<ESC>`>5l

" 删除光标所在处的链接或图片链接，link picture remove
" 详情查阅 ../../autoload/Markdown.vim
nnoremap <leader>mlr :call Markdown#RemoveLinkAtCursor()<CR>

" set filetype markdown --------------------------------------------------{{{1
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

" UngqFormat -------------------------------------------------------------{{{1
" 详情查阅 ../../autoload/Markdown.vim

" 恢复被 gq 格式化的文档格式
" :UngqFormat：处理整个文件。
" :'<,'>UngqFormat：处理当前选区。
command! -range=% UngqFormat call Markdown#UngqFormat(<line1>, <line2>)

finish " -----------------------------------------------------------------{{{1

" Toggle Todo checkbox ---------------------------------------------------{{{1
" 详情查阅 ../../autoload/Gtd.vim
command! -range ToggleTodoCheckbox <line1>,<line2>call Gtd#ToggleTodoCheckbox()
vnoremap <leader>mtd :ToggleTodoCheckbox<CR>
nnoremap <leader>mtd :ToggleTodoCheckbox<CR>

" 添加代码块标记 ---------------------------------------------------------{{{1
" 详情查阅 ../../autoload/Markdown.vim
command! -range WrapInCodeBlock <line1>,<line2>call Markdown#WrapInCodeBlock()
vnoremap <leader>mcb :WrapInCodeBlock<CR>
nnoremap <leader>mcb :WrapInCodeBlock<CR>

MarkdownLinkConceal ----------------------------------------------------{{{1
自动隐藏 markdown 链接
src: https://github.com/jakewvincent/mkdnflow.nvim/commits/main/lua/mkdnflow/conceal.lua
解决Mistook todo checkbox as markdown link，要将修订版放在 ~vimfiles/syntax/markdown.vim
src: https://github.com/tpope/vim-markdown/issues/212
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
