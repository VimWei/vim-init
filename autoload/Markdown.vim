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

finish

" WrapInCodeBlock --------------------------------------------------------{{{1
" 将选中的文本包装在代码块标记中
function! Markdown#WrapInCodeBlock() range
    " 获取选中的文本
    let lines = getline(a:firstline, a:lastline)
    let result = []

    " 添加开始标记
    call add(result, '```')
    " 添加选中的文本
    call extend(result, lines)
    " 添加结束标记
    call add(result, '```')

    " 删除选中的行
    execute a:firstline . ',' . a:lastline . 'delete'
    " 在删除的位置插入新的内容
    call append(a:firstline - 1, result)
endfunction
