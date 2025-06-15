let g:AutoAdapt_FilePattern = '*.md'
let g:AutoAdapt_LastLines = 5
let g:AutoAdapt_IsSkipOnRestore = 0
let g:AutoAdapt_Rules = [
\   {
\       'name': 'Modified timestamp',
\       'pattern': 'Modified: .*',
\       'replacement': 'Modified: ' . strftime('%Y\/%m\/%d %H:%M:%S'),
\       'range': 'modelines'
\   }
\]