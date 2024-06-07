" 采用类似 wiki 的导航机制

" Jump to a subject
nnoremap <buffer> <CR> <C-]>
" Jump back
nnoremap <buffer> <BS> <C-T>

" Lookup |label| using <Tab>/<S-Tab>
nnoremap <buffer> <Tab> /<Bar>\zs\k*\ze<Bar><CR>:noh<CR>
nnoremap <buffer> <S-Tab> ?<Bar>\zs\k*\ze<Bar><CR>:noh<CR>

" 快速退出
nnoremap <buffer> q :q<CR>
