" 拼音查询

" Basic function ----------------------------------------------------------{{{1

" 获取 vim-init 所在目录，末尾带"/"
let s:viminit = fnamemodify(resolve(expand('<sfile>:p')), ':h:h')
let s:viminit = substitute(s:viminit . '/', '\\', '/', 'g')

" 返回子目录或文件路径
function! s:cfg(path)
    let l:cfgfile = expand(s:viminit . a:path )
    let l:cfgfile = substitute(l:cfgfile, '\\', '/', 'g')
    return l:cfgfile
    " 转义 cfgfile 以便用作shell命令的参数
    " return shellescape(l:cfgfile)
endfunction

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
    let l:source1 = s:cfg("tools/dict/汉语拼音索引.md")
    let l:source2 = s:cfg("tools/dict/现代汉语常用词.md")
    let l:source3 = s:cfg("tools/dict/易混拼音识记.md")
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
    let l:source = s:cfg("tools/dict/汉语拼音索引.md")
    execute ":Leaderf! rg " . l:source . " --regexMode -e " . a:word
endfunction

" 查询输入的汉语单字/词汇/拼音 - 易混拼音
function! PinYin#Confusion(word)
    " 若存在已有Leaderf prompt窗口，则先将其退出
    if bufwinnr('*/LeaderF$') != -1
        execute ":" . bufwinnr('*/LeaderF$') . "q"
    endif
    let l:source = s:cfg("tools/dict/易混拼音识记.md")
    execute ":Leaderf! rg " . l:source . " --regexMode -e " . a:word
endfunction

" 使用pypinyin查询词汇拼音 ------------------------------------------------{{{1
" src: https://github.com/mozillazg/python-pinyin
" Requirements: 先在conda环境中安装 $ pip install pypinyin
" 可以使用参数调整拼音格式，如 $ pypinyin -s TONE3

" 使用 conda python 查询光标位置词汇的拼音
" function! PinYin#PyNormal()
"     let l:conda_python = $USERPROFILE . '\miniconda3\envs\pinyin\python.exe'
"     let l:current_word = expand('<cword>')
"     let l:cmd = '"' . l:conda_python . '" -m pypinyin -s TONE3 ' . l:current_word
"     " execute '!' . l:cmd
"     execute 'AsyncRun! -strip ' . l:cmd
" endfunction

" 使用 conda python 查询光标位置词汇的拼音
function! PinYin#PyNormal()
    let l:current_word = expand('<cword>')
    let l:command = 'pypinyin -s TONE3 ' . l:current_word
    call CondaPython#CondaEnvCommand('pinyin', 'async', l:command)
endfunction

" 查询选中内容的拼音
function! PinYin#PyVisual()
    let l:selection = @0
    let l:command = 'pypinyin -s TONE3 ' . l:selection
    call CondaPython#CondaEnvCommand('pinyin', 'async', l:command)
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
