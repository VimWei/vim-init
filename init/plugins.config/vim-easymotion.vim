" https://www.github.com/easymotion/vim-easymotion
" 全文快速移动，使用<leader><leader>w/b/s/j/k/l，或者f触发

let g:EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyz'
let g:EasyMotion_smartcase = 1
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_use_migemo  = 0

nmap <leader><leader>l <Plug>(easymotion-bd-jk)

" 类似vim的 / 检索，但强化了easymotion式快速定位
nmap f <Plug>(easymotion-sn)
" for Chinese or anytext
nnoremap <leader><leader>c <Cmd>nohlsearch<CR><Plug>(easymotion-sn)\_.\{8}<CR>
