" https://github.com/t9md/vim-choosewin

let g:choosewin_overlay_enable = 1
let g:choosewin_statusline_replace = 0

" nmap - <Plug>(choosewin)
" 避免与fugitive冲突
nmap <leader>cw <Plug>(choosewin)

" Tips
" <leader>cw -: Choose the previous window
" <leader>cw s{label}: swap the window in current tab with current window
" <leader>cw ss: swaps with the previous window

" 交换 win A 和 win B 的最佳实践
" 1. 先用任意可用方法，定位到 win A
" 2. 再用<leader>cw 定位到 win B，此时 Win A 是 previous window
" 3. 最后，使用<leader>cw ss，交换 win B 和 win A
