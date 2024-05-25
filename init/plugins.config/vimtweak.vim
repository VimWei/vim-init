" https://www.github.com/mattn/vimtweak
" 详情查阅 ../../autoload/Vimtweak.vim

" 切换窗口透明度 ---------------------------------------------------------{{{1
au GUIEnter * call libcallnr(g:vimtweak_dll_path, "SetAlpha", 230)
" <Leader>tw[0-9] 设置透明度程度，数字越大越透明
for i in range(0, 9)
    execute 'nnoremap <silent> <leader>tw' . i
          \ . ' :call libcallnr(g:vimtweak_dll_path, "SetAlpha", '
          \ . (255 - i * 10) . ')<CR>'
endfor

" 切换窗口的最大化状态 ---------------------------------------------------{{{1
au GUIEnter * call libcallnr(g:vimtweak_dll_path, "EnableMaximize", 1)
nnoremap <silent> <leader>twm :call Vimtweak#ToggleWindowMaximize()<CR>

" 切换窗口全屏状态 -------------------------------------------------------{{{1
" au GUIEnter * call libcallnr(g:vimtweak_dll_path, "EnableCaption", 0)
nnoremap <silent> <leader>twc :call Vimtweak#ToggleWindowCaption()<CR>

" 切换窗口的置顶状态 -----------------------------------------------------{{{1
nnoremap <silent> <leader>twt :call Vimtweak#ToggleWindowTopMost()<CR>
