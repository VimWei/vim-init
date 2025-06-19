" https://www.github.com/godlygeek/tabular
" video http://vimcasts.org/episodes/aligning-text-with-tabular-vim/
" 将文本按{pattern}对齐，使用 :Tabularize /{pattern}

if exists(":Tabularize")
    nmap <leader>a= :Tablularize /=<CR>
    vmap <leader>a= :Tablularize /=<CR>
    nmap <leader>a: :Tablularize /:\zs<CR>
    vmap <leader>a: :Tablularize /:\zs<CR>
endif
