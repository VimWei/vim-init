" 拼音查询

" 使用Leaderf查询单字的拼音、双拼、同音字、常用词组 -----------------------{{{1
function! PinYin#SingleWord()
    " 复制光标所在的单字
    let l:original_reg = getreg('z')
    normal! "zyl
    let l:text = getreg('z')
    call setreg('z', l:original_reg)

    " 若存在已有Leaderf prompt窗口，则先将其退出
    if bufwinnr('*/LeaderF$') != -1
        execute ":" . bufwinnr('*/LeaderF$') . "q"
    endif
    " 使用Leaderf查询以下来源，并直接进入Leaderf查询窗口的normal模式
    let l:source1 = g:viminit . "tools/dict/汉语拼音索引.md"
    let l:source2 = g:viminit . "tools/dict/现代汉语常用词.md"
    let l:source3 = g:viminit . "tools/dict/易混拼音识记.md"
    execute ":Leaderf! rg -e " . l:text .
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
    let l:source = g:viminit . "tools/dict/汉语拼音索引.md"
    execute ":Leaderf! rg " . l:source . " --regexMode -e " . a:word
endfunction

" 查询输入的汉语单字/词汇/拼音 - 易混拼音
function! PinYin#Confusion(word)
    " 若存在已有Leaderf prompt窗口，则先将其退出
    if bufwinnr('*/LeaderF$') != -1
        execute ":" . bufwinnr('*/LeaderF$') . "q"
    endif
    let l:source = g:viminit . "tools/dict/易混拼音识记.md"
    execute ":Leaderf! rg " . l:source . " --regexMode -e " . a:word
endfunction

" 使用pypinyin查询词汇拼音 ------------------------------------------------{{{1
" src: https://github.com/mozillazg/python-pinyin
" Requirements: 先在conda环境中安装 $ pip install pypinyin
" 可以使用参数调整拼音格式，如 $ pypinyin -s TONE3

" 查询光标下的单词或选中文本的拼音
function! PinYin#Words(mode)
    if a:mode == 'v'
        let l:original_reg = getreg('z')
        normal! gv"zy
        let l:text = getreg('z')
        call setreg('z', l:original_reg)
    else
        let l:text = expand('<cword>')
    endif
    let l:command = 'pypinyin -s TONE3 ' . l:text
    call CondaPython#CondaEnvCommand('pymotw', 'async', l:command)
endfunction

function! PinYin#Insert(mode)
    " 设置 Conda 环境中的 Python 路径
    let l:conda_python = $USERPROFILE . '\miniconda3\envs\pymotw\python.exe'
    if a:mode == 'v'
        let l:original_reg = getreg('z')
        normal! gv"zy
        let l:text = getreg('z')
        call setreg('z', l:original_reg)
    else
        let l:text = expand('<cword>')
    endif
    execute "normal! m`"
    execute ":-r!" . l:conda_python . " -m pypinyin " . shellescape(l:text, 1)
    execute "normal! `"
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
