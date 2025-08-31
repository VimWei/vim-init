function! Fold#AddMarker() " ---------------------------------------------{{{1
    " 1. 获取当前文件类型的注释前缀
    "    我们从 &commentstring (例如 "# %s") 中提取出 # 部分
    let comment_leader = substitute(&commentstring, '\s*%s.*$', '', '')

    " 2. 如果 commentstring 为空，提供一个默认值
    if empty(comment_leader)
        let comment_leader = '"'
    endif

    let current_line = getline('.')
    let current_line_length = strwidth(current_line)
    let textwidth = 78

    " 3. 判断是否已经是注释行 (适配新的注释符)
    "    注意：'^\s*' . comment_leader . '.*' 这种模式可以正确处理 #, " 等特殊字符
    let is_comment_line = current_line =~ '^\s*' . escape(comment_leader, '.*[]^%~')

    " 4. 根据是否是注释行，决定前缀
    let prefix = is_comment_line ? ' ' : ' ' . comment_leader . ' '
    let suffix = '{{{1'
    let fix_length = strlen(prefix) + strlen(suffix)
    let fill_length = textwidth - current_line_length - fix_length

    if fill_length > 0
        let dashes = repeat('-', fill_length)
        execute "normal! A" . prefix . dashes . suffix
    else
        execute "normal! A" . prefix . suffix
    endif
endfunction

function! Fold#ColumnToggle() " ------------------------------------------{{{1
    if &foldcolumn
        setlocal foldcolumn=0
    else
        setlocal foldcolumn=2
    endif
endfunction

function! Fold#ColumnOn() " ----------------------------------------------{{{1
    setlocal foldcolumn=2
endfunction

function! Fold#ColumnOff() " ---------------------------------------------{{{1
    setlocal foldcolumn=0
endfunction

function! Fold#Level(level) " --------------------------------------------{{{1
    " 先关闭所有折叠（这会自动启用折叠功能）
    normal! zM
    call Fold#ColumnOn()

    " 设置折叠参数
    let max_nest = a:level + 1
    execute 'setlocal foldnestmax=' . max_nest
    execute 'setlocal foldlevel=' . a:level

    " 显示当前折叠状态，注意：
    " 若 foldmethod 为 indent 或 marker，则 foldnestmax 起作用
    " 若 foldmethod 为 syntax 或 expr，则 foldnestmax 不起作用
    echo "set foldnestmax=" . (a:level + 1) . ", foldlevel=" . a:level
endfunction
