" 生成图片词典页码，参数为页码数
function! Mdict#CreatPageNum(TotalPageNum)
    silent! let currentLine = line(".")
    silent! exe "normal ".a:TotalPageNum."o"
    silent! exe "normal " . (currentLine+1) . "G"
    silent! let currentLine = line(".")
    silent! ,$s/^/\=printf("%04d", line(".")-currentLine+1)/
    silent! noh
endfunction

" 将图片词典页码转化为mdx源文件，参数为词典名
" com! -nargs=1 MPM call Mdict#PageNumToMdict(<f-args>)
function! Mdict#PageNumToMdict(CSSName, picNamePrefix, minPageNum, maxPageNum)
    silent! exe "normal gg"
    silent! %s/^\(0*\)\(\d\+\)$/\=submatch(0)
            \." ".printf("%04d",PreviousPageNum(submatch(2), a:minPageNum))
            \." ".printf("%04d",NextPageNum(submatch(2), a:maxPageNum))/e
    silent! %s/^\(\d\{4}\)\s\(\d\{4}\)\s\(\d\{4}\)$/
            \MDICTPICNAMEPREFIX_\1\r
            \<link rel="stylesheet" type="text\/css" href="MDICTCSSNAME\.css" \/>
            \<div class="pagination_top"><a href="entry:\/\/MDICTPICNAMEPREFIX_\2">Previous<\/a>
            \<a href="entry:\/\/MDICTPICNAMEPREFIX_\3">Next<\/a><\/div>
            \<div class="mainbodyimg"><img src="\/MDICTPICNAMEPREFIX_\1\.png" \/><\/div>
            \<div class="pagination_bottom"><a href="entry:\/\/MDICTPICNAMEPREFIX_\2">Previous<\/a>
            \<a href="entry:\/\/MDICTPICNAMEPREFIX_\3">Next<\/a><\/div>\r
            \<\/>/e
    silent! %s/MDICTCSSNAME/\=a:CSSName/e
    silent! %s/MDICTPICNAMEPREFIX/\=a:picNamePrefix/ge
endfunction

" 当前页为第一页时，上一页依然为第一页
function! PreviousPageNum(PageNumber, minPageNum)
    if (a:PageNumber-1)>a:minPageNum
        return a:PageNumber-1
    else
        return a:minPageNum
    endif
endfunction

" 当前页为最后一页时，下一页依然为最后一页
function! NextPageNum(PageNumber, maxPageNum)
    if (a:PageNumber+1)>a:maxPageNum
        return a:maxPageNum
    else
        return a:PageNumber+1
    endif
endfunction

" 将词条转化为mdx源文件，参数为词典名
" 词条原始格式：四位数的页码\r每行一个词条
" 根据图片文件名前缀不同，修订参数名称
" com! -nargs=1 MIM call Mdict#ItemToMdx(<f-args>)
function! Mdict#ItemToMdx(picNamePrefix)
    silent! exe "normal gg"
    " 将格式转化为：页码 tab 词条，每行一个词条
    while line('.') < line('$')
        call MdictPageItem()
    endwhile
    " 删除所有仅有数字的行
    silent! %s/\v^\d{4}$\n//
    " 将'页码 tab 词条'转化为mdx格式
    silent! %s/\v^(\d{4})\s{4}(.+)$/\2\r@@@LINK=MDICTPICNAMEPREFIX\1\r\<\/\>/
    silent! %s/@@@LINK=MDICTPICNAMEPREFIX/\="@@@LINK=" . a:picNamePrefix/g
    silent! exe "normal gg"
endfunction

function! MdictPinyinItem(picNamePrefix)
    silent! exe "normal gg"
    " 将格式转化为：页码 tab 词条，每行一个词条
    " while line('.') < line('$')
    "     call MdictPageItem()
    " endwhile
    " 删除所有仅有数字的行
    silent! %s/\v^\d{4}$\n//
    " 将'页码 tab 词条'转化为mdx格式
    silent! %s/\v^(\d{4})\s{4}(.+)$/\2\r@@@LINK=MDICTPICNAMEPREFIX\1\r\<\/\>/
    silent! %s/@@@LINK=MDICTPICNAMEPREFIX/\="@@@LINK=" . a:picNamePrefix/g
    silent! exe "normal gg"
endfunction

function! MdictPageItem()
    let l:startLine = line('.')
    let l:lastLine = line('$')
    let l:endLine = search('\v^\d{4}$')
    if endLine > startLine
        let l:linesQuantity = endLine - startLine - 1
    else
        let l:linesQuantity = lastLine - startLine
    endif
    silent! exe "normal ".startLine."gg"
    silent! exe 'normal "iyiwj'
    let @m = '0"iPa    j'
    silent! exe "normal ".linesQuantity.'@m'
endfunction

" 将所有行移动到页面中间位置
" nnoremap <leader>mp :call Mdict#MiddlePage()<CR>
function! Mdict#MiddlePage()
    while line('.') < line('$')
        let l:startLine = line('.')
        let l:lastLine = line('$')
        let l:endLine = search('\v^\d{4}')
        if endLine > startLine
            let l:targetLine = startLine + float2nr(round((endLine - startLine - 1)/2))
        else
            let l:targetLine = startLine + float2nr(round((lastLine - startLine)/2))
        endif
        silent! exe "normal ".startLine."gg"
        if targetLine < lastLine
            silent! exe 'normal dd'.targetLine.'GP'
            silent! exe "normal ".search('\v^\d{4}')."gg"
        endif
    endwhile
endfunction

" Mdict词典源文件编辑
" <leader>tp可切换至下一栏
" 结合AHK的Capslock+p，可在此基础上自动翻页图片
" nnoremap <leader>tp :call Mdict#TogglePage()<CR>
function! Mdict#TogglePage()
    " 将左侧窗口编辑行下移一行
    exe "normal \<C-W>hjzz\<C-W>p"
    " 切换当前词条编辑窗口大小，适应双栏编辑
    if winwidth(0) <= &columns/2
        if &columns == 192
            exe "normal 142\<C-W>|"
        else
            exe "normal 114\<C-W>|"
        endif
        exe "normal zt"
    else
        if &columns == 192
            exe "normal 63\<C-W>|"
        else
            exe "normal 43\<C-W>|"
        endif
        exe "normal zt"
    endif
endfunction
