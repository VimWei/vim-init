" Netrw

" 不显示横幅，可以用I轮换
let g:netrw_banner = 1
" 瘦列表 (每个文件一行)，可以用i轮换
let g:netrw_liststyle = 0
" 排序时忽略大小写，可以用s轮换排序依据
let g:netrw_sort_options="i"
" 指定新建的 :Lexplore 窗口宽度，单位是屏幕的百分比
let g:netrw_winsize =20

" 在当前窗口打开当前缓冲区所在目录
map - :<C-u>e %:p:h<CR>
" 在左侧显示当前缓冲区所在目录
map <C-n> :Lexplore %:p:h<CR>
