" 采用类似 wiki 的导航机制

" 进入：跳转到光标所在的关键字的定义
nnoremap <buffer> <CR> <C-]>
" 后退：跳到标签栈上较早的项目
nnoremap <buffer> <BS> <C-T>

if &filetype == 'help'
    " Lookup |label| using <Tab>/<S-Tab>
    nnoremap <buffer> <Tab> /<Bar>\zs\k*\ze<Bar><CR>:noh<CR>
    nnoremap <buffer> <S-Tab> ?<Bar>\zs\k*\ze<Bar><CR>:noh<CR>
endif

" 快速退出
nnoremap <buffer> q :q<CR>
