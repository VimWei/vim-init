" https://www.github.com/mkropat/vim-ezguifont
" 让支持GUI环境的 vim/nvim 放大缩小字号，M即Alt键
" 注：vim 不支持这些组合键 <C--><C-=><C-+><C-0>

nnoremap <silent> <M-Down> :DecreaseFont<CR>
nnoremap <silent> <M-Up> :IncreaseFont<CR>
nnoremap <silent> <M-Home> :ResetFontSize<CR>
