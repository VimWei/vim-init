" http://www.github.com/tyru/open-browser.vim
" gx使用系统默认工具打开光标下的文件、URL等

let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)
