" 将普通行转为列表行；更改列表行的列表符号 -------------------------------{{{1
" 支持以下列表形式
" - Hyphenated lists
" * Star (or bullet) lists
" + Plus (also bullet) lists
" 1. Numeric lists
" 2) or this style of numeric lists
" A. alphabetic lists
" a) or this style of alphabetic

function! List#ChangeSymbol(count, new_symbol) abort
    let l:count = a:count ? a:count : 1
    let l:start_line = line('.')
    let l:end_line = l:start_line + l:count - 1
    for lnum in range(l:start_line, l:end_line)
        let l:line = getline(lnum)
        let l:indent = matchstr(l:line, '^\s*')
        if l:line =~# '^\s*\(\([-*+]\|\d\+[.)]\|[a-zA-Z][.)]\)\s\+\)'
            if a:new_symbol == 'd'
                " 如果是列表项，移除列表符号及后续空格
                let l:line = l:indent . substitute(l:line, '^\s*\([-*+]\|\d\+[.)]\|[a-zA-Z][.)]\)\s\+', '', '')
            else
                " 如果是列表项，替换列表符号并保留一个空格
                let l:line = substitute(l:line, '^\s*\zs\([-*+]\|\d\+[.)]\|[a-zA-Z][.)]\)\ze\s\+', '', '')
                let l:line = l:indent . a:new_symbol . ' ' . matchstr(l:line, '\S.*$')
            endif
        else
            if a:new_symbol != 'd'
                " 如果不是列表项，则在文字之前、空格之后添加新的列表符号
                let l:content = matchstr(l:line, '\S.*$')
                let l:line = l:indent . a:new_symbol . ' ' . l:content
            endif
        endif
        call setline(lnum, l:line)
    endfor
endfunction
