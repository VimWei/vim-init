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

" <leader>pp :PyPinyin  --------------------------------------------------{{{1

" 拼音风格配置字典（可扩展）
let s:pinyin_styles = {
            \ 'n': ['NORMAL', '无声调拼音', 'ni hao'],
            \ 't': ['TONE', '带声调拼音', 'nǐ hǎo'],
            \ 'd': ['TONE2', '声调数字后缀', 'ni3 hao3'],
            \ 'f': ['FIRST_LETTER', '首字母连写', 'nh'],
            \ 'i': ['INITIALS', '声母', 'n h']
            \ }

" 显示拼音风格选择菜单
function! PinYin#ShowStyleMenu()
    " let l:keys = keys(s:pinyin_styles)
    let l:keys = ['n', 'd', 'f']
    echo "请选择拼音风格:"
    for key in l:keys
        let style = s:pinyin_styles[key]
        echohl Identifier
        echo printf("%-2s) ", key)
        echohl None
        echon printf("%-14s %-18s 示例: %s", style[0], style[1], style[2])
    endfor
    echohl Question
    echo "输入选择 (默认NORMAL): "
    echohl None
endfunction

function! PinYin#ConvertLines(...) range abort
    let l:conda_python = $USERPROFILE . '\miniconda3\envs\pymotw\python.exe'
    let l:save_cursor = getpos('.')
    let l:style_key = 'n' " 默认风格

    " 若无参数则采用NORMAL风格，否则要么指定风格，要么显示选择菜单
    if a:0 > 0
        if a:1 ==? 'menu'
            " 显示风格选择菜单
            call PinYin#ShowStyleMenu()
            let l:choice = nr2char(getchar())
            let l:style_key = tolower(l:choice)
        else
            " 直接使用传入的风格参数
            let l:style_key = tolower(a:1)
        endif
    endif

    " 获取风格配置
    let l:style = get(s:pinyin_styles, l:style_key, s:pinyin_styles['n'])
    if type(l:style) == type([]) && len(l:style) >= 3
        " echo "\n选择: " . l:style[1] . " (" . l:style[0] . ")"
    else
        let l:style = s:pinyin_styles['n']
        " echo "\n使用默认风格: NORMAL"
    endif

    " 遍历目标行
    for l:lnum in range(a:firstline, a:lastline)
        let l:line = getline(l:lnum)
        let l:text = trim(l:line)
        if empty(l:text) | continue | endif

        " 获取拼音
        let l:cmd = l:conda_python . ' -m pypinyin -s ' . l:style[0] . ' ' . shellescape(l:text)
        let l:pinyin = substitute(system(l:cmd), '\n', '', 'g')
        let l:pinyin = substitute(l:pinyin, 'ü', 'v', 'g')  " ü→v转换

        " 构造新行：原始文本 + Tab + 拼音
        call setline(l:lnum, l:text . "\t" . l:pinyin)
    endfor
    call feedkeys("\<Esc>")  " 强制返回Normal模式
    redraw!                  " 清除命令行残留显示

    call setpos('.', l:save_cursor)
endfunction

