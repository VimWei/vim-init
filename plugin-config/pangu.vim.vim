let g:pangu_rule_date = 1

" 普通模式：处理单行
nnoremap <leader>pg :Pangu<CR>
" 可视模式：处理选中的文本
vnoremap <leader>pg :Pangu<CR>
" 普通模式：处理整个文件
nnoremap <leader>pG :PanguAll<CR>
