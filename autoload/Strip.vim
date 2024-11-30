" 保存时自动删除行尾空格、重复空行和文件末尾的所有空行
" Remove trailing whitespace when writing a buffer, but not for diff files.
function! Strip#TrailingWhitespace()
    if &ft != "diff"
        let l:winview = winsaveview()
        " 删除行尾空格
        silent! %s/\s\+$//
        " 删除重复的多个空行，仅保留一个
        silent! %s/^$\n\(^$\)\@=//
        " 删除文件末尾的所有空行
        " silent! %s/\(\s*\n\)\+\%$//
        call winrestview(l:winview)
    endif
endfunction
