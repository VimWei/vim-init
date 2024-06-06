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

" Neovide ----------------------------------------------------------------{{{1
" 详情查阅 ../autoload/Neovide.vim
if exists("g:neovide")
    " 设置参数
    let g:neovide_underline_stroke_scale = 0.1
    let g:neovide_scroll_animation_length = 0.13
    let g:neovide_cursor_trail_size = 0.3

    " 切换窗口透明度
    let g:neovide_transparency = 0.9
    for i in range(0, 9)
        execute 'nnoremap <silent> <leader>tw' . i
            \ . ' :let g:neovide_transparency = '
            \ . (1 - i * 0.1) . '<CR>'
    endfor
    let g:neovide_fullscreen = v:false

    " 切换窗口全屏状态
    nnoremap <leader>twc :call Neovide#ToggleFullscreen()<CR>
endif
