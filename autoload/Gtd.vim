" ============================================================================
" GTD Todo 项辅助函数 (定义在 .vimrc 或单独的 .vim 文件中)
" ============================================================================

" 定义公共变量 -----------------------------------------------------------{{{1

let s:markdown_list_symbols = [
    \ '*',
    \ '-',
    \ '+',
    \ '1.',
    \ 'a.',
    \ 'A.',
    \ 'i.',
    \ 'I.',
    \ ]

" 生成列表符号的正则表达式模式
let s:markdown_list_pattern = '\v^(' . join(map(copy(s:markdown_list_symbols), 'escape(v:val, ".*+?^$()[]{}|\\")'), '|') . ')'

" ToggleTodoCheckbox -----------------------------------------------------{{{1
" 切换列表项的 todo checkbox（在普通列表项和 todo 列表项之间切换）
function! Gtd#ToggleTodoCheckbox() range
    " 获取选中的文本
    let lines = getline(a:firstline, a:lastline)
    let result = []

    for line in lines
        " 获取前导空格
        let indent = matchstr(line, '^\s*')
        " 去除前导空格后的文本
        let content = substitute(line, '^\s*', '', '')

        " 检查是否是 todo 列表项（包含 [ ] 或 [x] 等标记）
        if content =~ s:markdown_list_pattern . '\s*\[\s*[ x]\s*\]'
            " 是 todo 列表项，转换为普通列表项
            " 获取列表符号（可能是多个字符，如 '1.'）
            let prefix = matchstr(content, s:markdown_list_pattern)
            " 匹配完整的 todo 列表前缀（包括列表符号、[ ] 标记和空格）
            let full_prefix_match = matchstr(content, s:markdown_list_pattern . '\s*\[\s*[ x]\s*\]\s*')
            let rest = strpart(content, len(full_prefix_match))
            let new_line = indent . prefix . ' ' . rest
        elseif content =~ s:markdown_list_pattern
            " 是普通列表项，转换为 todo 列表项
            let prefix = matchstr(content, s:markdown_list_pattern)
            " 匹配完整的普通列表前缀（包括列表符号和空格）
            let full_prefix_match = matchstr(content, s:markdown_list_pattern . '\s*')
            let rest = strpart(content, len(full_prefix_match))
            let new_line = indent . prefix . ' [ ] ' . rest
        else
            " 不是列表项，转换为带 todo 标记的列表项（使用第一个列表符号，即 *）
            let new_line = indent . s:markdown_list_symbols[0] . ' [ ] ' . substitute(content, '^\s*', '', '')
        endif

        call add(result, new_line)
    endfor

    " 替换选中的行
    call setline(a:firstline, result)
endfunction

" GenerateTodoString --------------------------------------------------{{{1
" 生成带有本地化时间戳的 GTD todo 项字符串
" 支持多种列表符号和前导空格，并保持原有缩进
function! Gtd#GenerateTodoString() abort
    " 获取当前行内容
    let l:line = getline('.')

    " 获取前导空格
    let l:indent = matchstr(l:line, '^\s*')
    " 去除前导空格后的文本
    let content = substitute(l:line, '^\s*', '', '')

    " 获取本地化的时间戳
    let l:timestamp = strftime("%Y-%m-%d %A")

    " 检查是否是 todo 列表项（包含 [ ] 或 [x] 等标记）
    if content =~ s:markdown_list_pattern . '\s*\[\s*[ x]\s*\]'
        " 是 todo 列表项
        " 获取列表符号（可能是多个字符，如 '1.'）
        let prefix = matchstr(content, s:markdown_list_pattern)
        " 移除 [ ] 或 [x] 标记及其前后的空格
        let rest = substitute(content, '^' . escape(prefix, '.*+?^$()[]{}|\\') . '\s*\[\s*[ x]\s*\]\s*', '', '')
        let todo_replacement = l:timestamp
    elseif content =~ s:markdown_list_pattern
        " 是普通列表项，转换为 todo 列表项
        let prefix = matchstr(content, s:markdown_list_pattern)
        let rest = substitute(content, '^' . escape(prefix, '.*+?^$()[]{}|\\') . '\s*', '', '')
        let todo_replacement = '[ ] ' . l:timestamp
    else
        " 不是列表项，转换为带 todo 标记的列表项（使用第一个列表符号，即 *）
        let prefix = s:markdown_list_symbols[0]
        let rest = substitute(content, '^\s*', '', '')
        let todo_replacement = prefix . ' [ ] ' . l:timestamp
    endif

    return todo_replacement
endfunction
