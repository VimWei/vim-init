" fold
function! Fold#AddMarker()
    let current_line = getline('.')
    let current_line_length = strwidth(current_line)
    let textwidth = 78
    let is_comment_line = current_line =~ '^\s*"'
    let prefix = is_comment_line ? ' ' : ' " '
    let suffix = '{{{1'
    let fix_length = strlen(prefix) + strlen(suffix)
    let fill_length = textwidth - current_line_length - fix_length
    if fill_length > 0
        let dashes = repeat('-', fill_length)
        execute "normal! A" . prefix . dashes . suffix
    else
        execute "normal! A" . prefix . suffix
    endif
endfunction
