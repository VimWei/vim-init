" HtmlTidy
"
" 请参考使用:Autoformat
" Plug 'Chiel92/vim-autoformat'
"
" 将tidy加入系统path:高级系统设置/高级/环境变量/path/编辑/新建/浏览/确定
" 打开或切换窗口到拟处理的文件
" 使用如下命令实施Tidy美化，并输出文件到CWD中
" nnoremap <leader>ht :call HtmlTidy#Tidy()<CR>
function! HtmlTidy#Tidy() abort
    exe "w"
    silent!exe "cd %:h"
    let l:TidyOutput = expand('%:t:r') . "." . strftime("%Y%m%d.%H%M%S") . ".html"
    exe "!tidy -config d:\\WeirdData\\Vim\\Tidy-HTML5\\config.vim \"%\" > \"" . TidyOutput . "\""
    echo "Please check Tidy Output .html File in CWD: " . getcwd()
endfunction

" 采用VimScript简化版
" nnoremap <leader>hp :call HtmlTidy#Prettify()<CR>
function! HtmlTidy#Prettify() abort
    if &ft != 'html'
        set filetype=html
    endif
    silent! exe "%s/<[^>]*>/\r&\r/g"
    silent! exe "g/^\s*$/d"
    exe "normal ggVG="
endfunction
