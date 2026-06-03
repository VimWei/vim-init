" Label

" AddLabel --------------------------------------------------------------{{{1
" 在当前行添加 label: 标记
" 如果是列表行，在列表符号后添加 label:
" 如果是普通行，在行首添加 * label: 
function! Label#AddLabel(label) abort
    let line = getline('.')
    let list_pattern = '^\s*[*\-+]\s\+'
    
    if line =~ list_pattern
        " 列表行：在列表符号后添加 label:
        let newline = substitute(line, '\(\s*[*\-+]\s\+\)', '\1' . a:label . ': ', '')
    else
        " 普通行：在行首添加 * label: 
        let newline = '* ' . a:label . ': ' . line
    endif
    
    call setline('.', newline)
endfunction