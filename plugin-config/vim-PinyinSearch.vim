" https://www.github.com/ppwwyyxx/vim-PinyinSearch
" 拼音首字母查询
" PinyinSearch.dict来自插件根目录，指向tools/dict/是为了兼容vim/neovim

let g:PinyinSearch_Dict = g:viminit . 'tools/dict/PinyinSearch.dict'
nnoremap F :call PinyinSearch()<CR>
nnoremap <Leader>pn :call PinyinNext()<CR>
