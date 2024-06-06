" https://www.github.com/mkropat/vim-ezguifont
" https://www.codetinkerer.com/2023/01/16/how-to-adjust-gui-font-size-vim-neovim.html

" 支持 GUI 环境的 vim/nvim 可自由放大缩小字号
" 注意：vim 不支持这些组合键 <C--><C-=><C-+><C-0>

nnoremap <silent> <M-Down> :DecreaseFont<CR>
nnoremap <silent> <M-Up> :IncreaseFont<CR>
nnoremap <silent> <M-Home> :ResetFontSize<CR>
