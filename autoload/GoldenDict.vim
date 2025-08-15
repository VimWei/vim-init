" GoldenDict.vim
" 查询当前单词/选区并发送到 GoldenDict
function! GoldenDict#Lookup(mode)
    " 备份寄存器
    let save_reg = @"
    let save_reg_type = getregtype('"')
    let word = ""

    if a:mode == 'v'
        " 可视模式处理
        silent normal! gvy
        let word = @"
        " 退出可视模式
        silent normal! \<Esc>
    else
        " 普通模式处理
        let word = expand("<cword>")
    endif

    " 恢复寄存器
    call setreg('"', save_reg, save_reg_type)

    " 清理单词：去除多余空格和两端符号
    let word = substitute(word, '\_s\+', ' ', 'g')
    let word = substitute(word, '^\W*\(.\{-}\)\W*$', '\1', '')

    if word == ""
        echohl ErrorMsg | echo "无可用查询内容" | echohl None
        return
    endif

    " 准备系统命令
    let cmd = ""
    if has("win32") || has("win64")
        let cmd = 'start /b c:\Apps\GoldenDict\GoldenDict.exe "' . word . '"'
    elseif has("mac")
        let cmd = 'open -a GoldenDict --args "' . word . '"'
    else
        let cmd = 'goldendict "' . word . '" &'
    endif

    " 执行命令（异步）
    silent! call system(cmd)
    echo "正在查询: " . word
endfunction

finish

" 简单粗暴版，需要使用 goldendict 的快捷键 ctrl+c+c
"nnoremap <c-c> <esc>muhebyiw`u
nnoremap <c-c> <esc>muyiw`u
"inoremap <c-c> <esc>muhebyiw`ua
inoremap <c-c> <esc>muyiw`ua
vnoremap <c-c> ygv
