" https://www.github.com/easymotion/vim-easymotion

" <leader><leader>w/b/s/j/k 全文快速跳转 ---------------------------------{{{1
let g:EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyz'
let g:EasyMotion_smartcase = 1
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_use_migemo  = 0

" <leader><leader>l 行跳转 -----------------------------------------------{{{1
nmap <leader><leader>l <Plug>(easymotion-bd-jk)

" f 全文检索跳转 ---------------------------------------------------------{{{1
" 类似vim的 / 检索，但强化了easymotion式快速定位
nmap f <Plug>(easymotion-sn)

" <leader><leader>c 固定间隔定位跳转，适配中文等情形 ---------------------{{{1
" nnoremap <leader><leader>c <Cmd>nohlsearch<CR><Plug>(easymotion-sn)\_.\{8}<CR>
" 在执行后会保持高亮，只能手动取消高亮，建议采用 vim9-stargate 更直接高效
