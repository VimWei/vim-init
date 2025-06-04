" https://github.com/monkoose/vim9-stargate

let g:stargate_chars = 'abcdefghijklmnopqrstuvwxyz'
" for the start of a line
nnoremap <leader>l <Cmd>call stargate#OKvim('\_^')<CR>
" for the end of a line
nnoremap <leader>$ <Cmd>call stargate#OKvim('$')<CR>
" for Chinese or anytext
nnoremap <leader><leader>c <Cmd>call stargate#OKvim('.\{5}')<CR>
