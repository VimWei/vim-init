" text-processor search path, a comma separated string
let g:textproc_root = '../tools/text'

" preview window split method: auto/vert/horizon
let g:textproc_split = 'auto'

" filter runner
let g:textproc_runner = {
    \ 'py': 'python',
    \ 'sh': '/usr/bin/bash',
    \ 'awk': '/usr/bin/gawk -f',
    \ }
