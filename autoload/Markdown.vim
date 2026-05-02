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
