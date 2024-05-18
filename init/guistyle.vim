"===================================================
" GUI settings by W.Chen
" Sourced by: ../init.vim
"===================================================

if !has("gui_running")
    finish
endif

" guioptions -------------------------------------------------------------{{{1

set guioptions-=m   "隐藏菜单
set guioptions-=T   "隐藏工具栏
set guioptions-=r   "隐藏右滚动条
set guioptions-=L   "隐藏垂直分割窗口的左滚动条
set guioptions-=e   "使用非 GUI 标签页行
set showtabline=2   "总是显示标签栏

set lines=18 columns=85    "非最大化时，窗口的高度和宽度
set guifont=Consolas:h14:cANSI:qDRAFT   "字体及大小
set linespace=7    "行间距

if !has('nvim')
    set renderoptions=type:directx,renmode:5    "增强显示
endif

" guifont++ --------------------------------------------------------------{{{1
"让vim像IDE一样一键放大缩小字号，M即Alt键
let guifontpp_size_increment=1 "每次更改的字号
let guifontpp_smaller_font_map="<M-Down>"
let guifontpp_larger_font_map="<M-Up>"
let guifontpp_original_font_map="<M-Home>"

" vimtweak ---------------------------------------------------------------{{{1
" 详情查阅 ../autoload/Vimtweak.vim

" 切换窗口透明度
if exists("g:neovide")
    let g:neovide_transparency = 0.9
    for i in range(0, 9)
        execute 'nnoremap <silent> <leader>tw' . i
            \ . ' :let g:neovide_transparency = '
            \ . (1 - i * 0.1) . '<CR>'
    endfor
    finish
else

au GUIEnter * call libcallnr(g:vimtweak_dll_path, "SetAlpha", 230)
" <Leader>tw[0-9] 设置透明度程度，数字越大越透明
for i in range(0, 9)
    execute 'nnoremap <silent> <leader>tw' . i
          \ . ' :call libcallnr(g:vimtweak_dll_path, "SetAlpha", '
          \ . (255 - i * 10) . ')<CR>'
endfor

" 切换窗口的最大化状态
au GUIEnter * call libcallnr(g:vimtweak_dll_path, "EnableMaximize", 1)
nnoremap <silent> <leader>twm :call Vimtweak#ToggleWindowMaximize()<CR>

" 切换窗口的标题栏状态
" au GUIEnter * call libcallnr(g:vimtweak_dll_path, "EnableCaption", 0)
nnoremap <silent> <leader>twc :call Vimtweak#ToggleWindowCaption()<CR>

" 切换窗口的置顶状态
nnoremap <silent> <leader>twt :call Vimtweak#ToggleWindowTopMost()<CR>
