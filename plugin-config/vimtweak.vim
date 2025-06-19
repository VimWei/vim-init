" https://www.github.com/mattn/vimtweak
" 详情查阅 ../../autoload/Vimtweak.vim

" 初始化窗口设置 ---------------------------------------------------------{{{1
augroup VimTweakInit
    autocmd!
    au GUIEnter * call libcallnr(g:vimtweak_dll_path, "SetAlpha", 230)
    au GUIEnter * call libcallnr(g:vimtweak_dll_path, "EnableMaximize", 1)
    " au GUIEnter * call libcallnr(g:vimtweak_dll_path, "EnableCaption", 0)
augroup END

" 配置窗口状态 -----------------------------------------------------------{{{1

" 设置透明度程度，<Leader>tw[0-9] 数字越大越透明
for i in range(0, 9)
    execute 'nnoremap <silent> <leader>tw' . i
          \ . ' :call libcallnr(g:vimtweak_dll_path, "SetAlpha", '
          \ . (255 - i * 10) . ')<CR>'
endfor

" 切换窗口的最大化状态
nnoremap <silent> <leader>twm :call Vimtweak#ToggleWindowMaximize()<CR>

" 切换窗口全屏状态
nnoremap <silent> <leader>twc :call Vimtweak#ToggleWindowCaption()<CR>

" 切换窗口的置顶状态
nnoremap <silent> <leader>twt :call Vimtweak#ToggleWindowTopMost()<CR>
