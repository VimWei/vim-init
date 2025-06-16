let g:AutoAdapt_FilePattern = '*.md'
let g:AutoAdapt_FirstLines = 0
let g:AutoAdapt_LastLines = 5
let g:AutoAdapt_IsSkipOnRestore = 0
let g:AutoAdapt_Rules = [
\   {
\       'name': 'Modified timestamp',
\       'pattern': '\c^\(.\{,3}Modified: \)\d\{4}[-.\/]\?\d\{2}[-.\/]\?\d\{2}.*$',
\       'replacement': '\1' . strftime('%Y\/%m\/%d %H:%M:%S'),
\       'range': 'modelines'
\   }
\]
