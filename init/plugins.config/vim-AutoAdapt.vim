let g:AutoAdapt_FilePattern = ''
let g:AutoAdapt_LastLines = 5
let g:AutoAdapt_Rules = [
\   {
\       'name': 'Modified timestamp',
\       'pattern': '\cModified: \d{4}/\d{1,2}/\d{1,2} \d{1,2}:\d{2}:\d{2}$',
\       'replacement': 'Modified: ' . strftime('%Y/%#m/%#d %#H:%M:%S'),
\       'range': 'modelines'
\   },
\   {
\       'name': 'Created timestamp',
\       'pattern': '\cCreated: \d{4}/\d{1,2}/\d{1,2} \d{1,2}:\d{2}:\d{2}$',
\       'replacement': 'Created: ' . strftime('%Y/%#m/%#d %#H:%M:%S'),
\       'range': 'modelines'
\   }
\]
