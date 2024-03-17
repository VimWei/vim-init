" Markdown

" 全角数字转半角 ----------------------------------------------------------{{{1
function! Markdown#FullToHalfDigit()
    let s:full_to_half = {
                \ '１': '1', '２': '2', '３': '3', '４': '4', '５': '5',
                \ '６': '6', '７': '7', '８': '8', '９': '9', '０': '0',
                \ '％': '%'
                \ }
    for [l:full, l:half] in items(s:full_to_half)
        execute '%s/' . l:full . '/' . l:half . '/ge'
    endfor
endfunction

" UngqFormat --------------------------------------------------------------{{{1

" 恢复被 gq 格式化的文档格式
function! Markdown#UngqFormat(start_line, end_line) range
    let l:start_line = a:start_line
    let l:end_line = a:end_line

    " 保存当前 textwidth 设置，并临时设置为0
    let textwidth_save = &textwidth
    set textwidth=0

    " 初始化变量
    let reformatted_lines = []
    let list_item_regex = '^\s*\%(\d\+[.)]\|\a\+[.)]\|\c\mI\+[.)]\|-\|\*\|#\)\s'
    let chinese_char_regex = '[\u4e00-\u9fa5\·\！\，\。\？\；\：\“\”\‘\’\【\】\（\）\《\》\——\……\、]'

    " 处理范围内的每一行
    let i = l:start_line
    while i <= l:end_line
        let line_text = getline(i)
        if line_text =~ list_item_regex
            " 处理列表项
            if len(reformatted_lines) > 0 && reformatted_lines[-1] !~ list_item_regex && reformatted_lines[-1] !~ '^\s*$'
                call add(reformatted_lines, '')
            endif
            let list_block = line_text
            let i += 1
            while i <= l:end_line
                let next_line = getline(i)
                if next_line =~ '^\s*$' || next_line =~ list_item_regex
                    break
                endif
                let trimmed_next_line = substitute(next_line, '^\s\+', '', '')
                let last_char_of_current_line = matchstr(list_block, '.$')
                let first_char_of_next_line = matchstr(trimmed_next_line, '^\S')
                let space = ''
                if last_char_of_current_line =~ chinese_char_regex && first_char_of_next_line =~ chinese_char_regex
                    let space = ''
                else
                    let space = ' '
                endif
                let list_block .= space . trimmed_next_line
                let i += 1
            endwhile
            call add(reformatted_lines, list_block)
        else
            " 处理段落
            if line_text =~ '^\s*$'
                call add(reformatted_lines, line_text)
                let i += 1
            else
                let paragraph_block = line_text
                let i += 1
                while i <= l:end_line
                    let next_line = getline(i)
                    if next_line =~ '^\s*$' || next_line =~ list_item_regex
                        break
                    endif
                    let trimmed_next_line = substitute(next_line, '^\s\+', '', '')
                    let last_char_of_current_line = matchstr(paragraph_block, '.$')
                    let first_char_of_next_line = matchstr(trimmed_next_line, '^\S')
                    let space = ''
                    if last_char_of_current_line =~ chinese_char_regex && first_char_of_next_line =~ chinese_char_regex
                        let space = ''
                    else
                        let space = ' '
                    endif
                    let paragraph_block .= space . trimmed_next_line
                    let i += 1
                endwhile
                call add(reformatted_lines, paragraph_block)
            endif
        endif
    endwhile

    " 根据选区范围删除原文本，并插入重新格式化后的文本
    if l:start_line == 1 && l:end_line == line('$')
        %delete _
        call append(0, reformatted_lines)
        if getline('$') == ''
            execute '$d'
        endif
    else
        execute l:start_line . ',' . l:end_line . 'delete _'
        call append(l:start_line - 1, reformatted_lines)
    endif

    " 恢复 textwidth 设置
    let &textwidth = textwidth_save
endfunction
