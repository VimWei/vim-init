" 拼音查询

" Basic function ----------------------------------------------------------{{{1

" 获取 vim-init 所在目录，不带末尾的"/"
let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h:h')

" 返回tools所在路径 "s:home/path"；末尾是否包含"/"取决于path参数
function! s:path(path)
	let l:path = expand(s:home . '/' . a:path )
	return substitute(l:path, '\\', '/', 'g')
endfunction
" echo s:path('tools/conf/')

" 返回文件路径 "s:home/path/name"；为便于理解，要求path参数带末尾的"/"
function! s:cfg(path, name)
    let l:cfgpath = s:path(a:path)
    let l:cfgfile = l:cfgpath . a:name
    return l:cfgfile
    " 转义 cfgfile 以便用作shell命令的参数
    " return shellescape(cfgfile)
endfunction
" echo s:cfg('tools/conf/', 'file.cfg')

" 使用Leaderf查询单字的拼音、双拼、同音字、常用词组 -----------------------{{{1
function! PinYin#WordStar()
    " 复制光标所在的单字
    normal! yl
    let l:selection = @0
    " 若存在已有Leaderf prompt窗口，则先将其退出
    if bufwinnr('*/LeaderF$') != -1
        execute ":" . bufwinnr('*/LeaderF$') . "q"
    endif
    " 使用Leaderf查询以下来源，并直接进入Leaderf查询窗口的normal模式
    let l:source1 = s:cfg("tools/dict/", "汉语拼音索引.md")
    let l:source2 = s:cfg("tools/dict/", "现代汉语常用词.md")
    let l:source3 = s:cfg("tools/dict/", "易混拼音识记.md")
    execute ":Leaderf! rg -e " . l:selection .
        \ " " . l:source1
        \ " " . l:source2
        \ " " . l:source3
endfunction

" 使用Leaderf查询输入的单字/词汇/拼音 -------------------------------------{{{1

" 查询输入的汉语单字或拼音 - 拼音索引
function! PinYin#Index(word)
    " 若存在已有Leaderf prompt窗口，则先将其退出
    if bufwinnr('*/LeaderF$') != -1
        execute ":" . bufwinnr('*/LeaderF$') . "q"
    endif
    let l:source = s:cfg("tools/dict/", "汉语拼音索引.md")
    execute ":Leaderf! rg " . l:source . " --regexMode -e " . a:word
endfunction

" 查询输入的汉语单字/词汇/拼音 - 易混拼音
function! PinYin#Confusion(word)
    " 若存在已有Leaderf prompt窗口，则先将其退出
    if bufwinnr('*/LeaderF$') != -1
        execute ":" . bufwinnr('*/LeaderF$') . "q"
    endif
    let l:source = s:cfg("tools/dict/", "易混拼音识记.md")
    execute ":Leaderf! rg " . l:source . " --regexMode -e " . a:word
endfunction

" 使用pypinyin查询词汇拼音 ------------------------------------------------{{{1
" src: https://github.com/mozillazg/python-pinyin
" Requirements: 先安装 $ pip install pypinyin
" 可以使用参数调整拼音格式，如 $ pypinyin -s TONE3

" 查询当前光标下词汇的拼音
function! PinYin#PyNormal()
    " when '!' is included, auto-scroll in quickfix will be disabled.
    " <cword> represents current word under cursor.
    " :AsyncRun! -strip pypinyin <cword>
    :AsyncRun! -strip pypinyin -s TONE3 <cword>
endfunction

" 查询选中内容的拼音
function! PinYin#PyVisual()
    let l:selection = @0
    " execute ":AsyncRun! -strip pypinyin " . l:selection
    execute ":AsyncRun! -strip pypinyin -s TONE3 " . l:selection
endfunction

finish

" 旧版参考资料 ------------------------------------------------------------{{{1
" 使用pypinyin查询拼音
" pypinyin -s TONE3
nnoremap <leader>p :AsyncRun -strip pypinyin <C-r><C-w><CR>
vnoremap <leader>p y:AsyncRun -strip pypinyin <C-r>0<CR>
nnoremap <leader>pi :-r!pypinyin <C-r><C-w><CR>
vnoremap <leader>pi y:-r!pypinyin <C-r>0<CR>

" 使用Leaderf查询拼音
nnoremap <leader>pp vy:Leaderf! rg -e <C-r>0
    \ d:\WeirdData\VimwikiMD\汉语拼音索引.md
    \ d:\WeirdData\VimwikiMD\现代汉语常用词.md
    \ d:\WeirdData\VimwikiMD\易混拼音识记.md
    \<CR>
nnoremap <leader>py :<C-U><C-R>=printf("Leaderf! rg d:/WeirdData/VimwikiMD/汉语拼音索引.md --regexMode -e %s", "")<CR>
nnoremap <leader>pc :<C-U><C-R>=printf("Leaderf! rg d:/WeirdData/VimwikiMD/易混拼音识记.md --regexMode -e %s", "")<CR>
