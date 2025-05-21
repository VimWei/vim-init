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

" Explode2P ---------------------------------------------------------------{{{1

" 将行转为段落，并格式化，explode
function! Markdown#Explode2P() abort range
    let firstline = a:firstline
    let lastline = a:lastline
    if a:firstline == a:lastline
        let firstline = 1
        let lastline = line('$')
    endif
    let l:pattern = '.\@<=$\n^\(.\+\)\@='

    " 计算有多少个满足pattern的匹配，并设计若没有匹配时的处理
    let l:cmd_match = firstline . ',' . lastline . 's/' . l:pattern . '//gn'
    redir => l:output_match
    try
        silent! execute l:cmd_match
    catch
        redir END
        return
    endtry
    redir END
    let l:match_count = split(l:output_match)[0] + 0

    " 执行满足pattern的替换
    let l:pattern = 's/' . l:pattern . '/\r\r/e'
    let l:pattern = firstline . ',' . lastline . l:pattern
    execute l:pattern
    nohlsearch

    " 对满足pattern的结果进行格式化
    if a:firstline == a:lastline
        let firstline = 1
        let lastline = line('$')
    else
        let firstline = a:firstline
        let lastline = a:lastline + l:match_count
    endif
    let addlines = lastline - firstline
    let l:cmd_format = 'normal! ' . firstline. 'GV' . addlines . 'jgq'
    execute l:cmd_format
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

" ViewImage --------------------------------------------------------------{{{1

function! Markdown#ViewImage()
    let current_line = getline('.')
    let cursor_col = col('.')
    let start_pos = 0
    let img_path = ''

    " 查找当前行中的所有图片标记
    while 1
        " 在当前位置之后查找图片标记的起始位置
        let img_start = match(current_line, '!\[.\{-}\](', start_pos)
        if img_start == -1
            break
        endif

        " 找到对应的右括号位置
        let img_end = match(current_line, ')', img_start)
        if img_end == -1
            break
        endif

        " 检查光标是否在这个图片标记的范围内
        if cursor_col > img_start && cursor_col <= img_end + 1
            " 提取这个图片的路径
            let img_path = matchstr(current_line[img_start : img_end], '!\[.\{-}\](\zs.\{-}\ze)')
            break
        endif

        let start_pos = img_end + 1
    endwhile

    if empty(img_path)
        echohl ErrorMsg | echo "未找到图片路径！" | echohl None | return
    endif

    " 检查是否是网址
    if img_path =~? '^https\?://'
        " 使用 open-browser.vim 打开网址
        call openbrowser#open(img_path)
        return
    endif

    " 检查是否是绝对路径
    if img_path =~? '^[A-Za-z]:[/\\]'
        " 如果是绝对路径，直接使用，但需要统一路径分隔符
        let final_path = substitute(img_path, '/', '\', 'g')
    else
        " 如果是相对路径，拼接当前目录
        let current_dir = substitute(expand('%:p:h'), '/', '\', 'g')
        let windows_path = substitute(img_path, '/', '\', 'g')
        let final_path = current_dir . '\' . windows_path
    endif

    " 添加引号并调用 IrfanView
    let safe_path = '"' . final_path . '"'
    let g:irfanview_path = '"C:\Program Files\IrfanView\i_view64.exe"'
    silent execute "!start " . g:irfanview_path . " " . safe_path
endfunction

" RemoveLinkAtCursor -----------------------------------------------------{{{1

function! Markdown#RemoveLinkAtCursor()
  let l:line = getline('.')
  let l:col = col('.')
  let l:pattern = '\v(!?)\[(.{-})\]\((.{-})\)'
  let l:start = 0
  while 1
    let l:match = matchstrpos(l:line, l:pattern, l:start)
    if empty(l:match)
      break
    endif
    let [l:matched, l:mstart, l:mend] = [l:match[0], l:match[1], l:match[2]]
    " 只在光标严格在链接内容内时才生效
    if l:col-1 >= l:mstart && l:col-1 < l:mend
      let l:text = matchstr(l:matched, '\v\[(.{-})\]')
      let l:text = l:text[1:-2]
      let l:newline = strpart(l:line, 0, l:mstart) . l:text . strpart(l:line, l:mend)
      call setline('.', l:newline)
      call cursor(line('.'), l:mstart+1)
      return
    endif
    " 防止死循环：如果没有前进，break
    if l:mend <= l:start
      break
    endif
    let l:start = l:mend
  endwhile
endfunction
