" Src

" AddSrc ---------------------------------------------------------------{{{1
" 在当前行添加 src: 标记
" 如果是列表行，在列表符号后添加 src:
" 如果是普通行，在行首添加 * src: 
function! Src#AddSrc() abort
    let line = getline('.')
    let list_pattern = '^\s*[*\-+]\s\+'
    
    if line =~ list_pattern
        " 列表行：在列表符号后添加 src:
        let newline = substitute(line, '\(\s*[*\-+]\s\+\)', '\1src: ', '')
    else
        " 普通行：在行首添加 * src: 
        let newline = '* src: ' . line
    endif
    
    call setline('.', newline)
endfunction