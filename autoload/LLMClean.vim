" 清理 AI 生成的 Markdown 文档格式

let s:items = [
    \ {'label': 'Delete lines starting with ---', 'cmd': '', 'enabled': 1},
    \ {'label': 'Promote H3+ headings by one level', 'cmd': '{range}s/###/##/g', 'enabled': 1},
    \ {'label': 'Add empty line after H2+ headings', 'cmd': '', 'enabled': 1},
    \ {'label': 'Remove all markdown text style', 'cmd': '', 'enabled': 1},
    \ {'label': 'Remove leading 2 spaces', 'cmd': '{range}s/^  //g', 'enabled': 1},
    \ {'label': 'Remove spaces after Chinese colon', 'cmd': '{range}s/： /：/g', 'enabled': 1},
    \ {'label': 'Remove redundant spaces after numbered list', 'cmd': '{range}s/\(\d\.\)\s\+/\1 /g', 'enabled': 1},
    \ {'label': 'Remove backslash in numbered lists', 'cmd': '{range}s/\(\d\+\)\\\(\.\)/\1\2/g', 'enabled': 1},
\]

" 执行顺序: 按界面显示顺序 1→2→3→4→5→6→7→8
let s:exec_order = [0, 1, 2, 3, 4, 5, 6, 7]

function! LLMClean#Run() range
    " 检测是否有范围传入
    " 优先使用 '< 和 '> 标记（可视模式选区）
    let l:visual_start = line("'<")
    let l:visual_end = line("'>")

    if l:visual_start > 0 && l:visual_end > 0 && (l:visual_start != l:visual_end || mode() =~# "[vV\<>]")
        let l:range = "'<,'>"
        let l:start_line = l:visual_start
        let l:end_line = l:visual_end
    else
        " 无范围：全文模式
        let l:range = '%'
        let l:start_line = 1
        let l:end_line = line('$')
    endif

    while 1
        let l:dialog_items = []
        for i in range(len(s:items))
            call add(l:dialog_items, {
                \ 'type': 'check',
                \ 'name': 'op_' . i,
                \ 'text': s:items[i].label,
                \ 'value': s:items[i].enabled,
                \ })
        endfor
        call add(l:dialog_items, {
            \ 'type': 'button',
            \ 'name': 'action',
            \ 'items': [' &Execute ', ' &Reset ', ' &Cancel '],
            \ })

        let l:result = quickui#dialog#open(l:dialog_items, {'title': 'LLMClean', 'focus': 'action'})

        if l:result.button_index < 0 || l:result.button_index == 2
            return
        endif

        if l:result.button_index == 1
            for item in s:items
                let item.enabled = 1
            endfor
            continue
        endif

        for i in range(len(s:items))
            let s:items[i].enabled = l:result['op_' . i]
        endfor

        call s:ExecuteItems(s:items, l:range, l:start_line, l:end_line)
        break
    endwhile
endfunction

function! s:ExecuteItems(items, range, start_line, end_line)
    let executed = 0
    let l:current_start = a:start_line
    let l:current_end = a:end_line
    
    for idx in s:exec_order
        if !a:items[idx].enabled
            continue
        endif
        
        " 记录操作前的总行数
        let l:lines_before = line('$')
        
        if idx == 3
            " Special handling: Remove all markdown text style
            if &filetype != 'markdown'
                continue
            endif
            " Execute: select range then apply <Plug>MarkdownRemoveAll
            if a:range != '%'
                " 选区模式：使用具体行号选中范围
                silent! execute printf('normal! %dG%dGV', l:current_start, l:current_end)
            else
                " 全文模式：全选
                silent! execute 'normal! ggVG'
            endif
            silent! execute "normal \<Plug>MarkdownRemoveAll"
            redraw!
            let executed += 1
        elseif idx == 2
            " Special handling: Add empty line after headings (except H1)
            call s:AddEmptyLineAfterHeadings(l:current_start, l:current_end)
            let executed += 1
        elseif idx == 0
            " Special handling: Delete lines starting with ---
            " 使用 while 循环从下往上删除，确保范围追踪准确
            call s:DeleteLinesStartingWith(l:current_start, l:current_end, '^---')
            let executed += 1
        else
            " Standard command execution: use concrete line numbers
            let l:range_str = a:range == '%' ? '%' : printf('%d,%d', l:current_start, l:current_end)
            let l:cmd = substitute(a:items[idx].cmd, '{range}', l:range_str, 'g')
            silent! execute l:cmd
            let executed += 1
        endif
        
        " 追踪行变化并调整范围
        let l:lines_after = line('$')
        let l:delta = l:lines_after - l:lines_before
        let l:current_end += l:delta
    endfor
    
    if executed == 0
        echo 'No operation selected.'
    else
        echo printf('LLMClean: %d operation(s) executed.', executed)
    endif
endfunction

function! s:DeleteLinesStartingWith(start_line, end_line, pattern)
    " 从下往上遍历并删除匹配的行，确保行号变化可预测
    let l:lnum = a:end_line
    while l:lnum >= a:start_line
        if getline(l:lnum) =~ a:pattern
            silent! execute printf('%dd', l:lnum)
        endif
        let l:lnum -= 1
    endwhile
endfunction

function! s:AddEmptyLineAfterHeadings(start_line, end_line)
    " 从下往上遍历，避免插入行影响未处理的行
    " 匹配除 H1 外的所有标题 (## 到 ######)
    let l:lnum = a:end_line
    while l:lnum >= a:start_line
        if getline(l:lnum) =~ '^##'
            let nextline = getline(l:lnum + 1)
            if nextline !~ '^$'
                call append(l:lnum, '')
            endif
        endif
        let l:lnum -= 1
    endwhile
endfunction
