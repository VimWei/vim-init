" Vimtweak

" 切换窗口的最大化状态 ---------------------------------------------------{{{1
function! Vimtweak#ToggleWindowMaximize()
    if !exists('s:window_maximize')
        let s:window_maximize = 1
    endif
    if s:window_maximize
        call libcallnr(g:vimtweak_dll_path, "EnableMaximize", 0)
        let s:window_maximize = 0
    else
        call libcallnr(g:vimtweak_dll_path, "EnableMaximize", 1)
        let s:window_maximize = 1
    endif
endfunction

" 切换窗口全屏状态 -------------------------------------------------------{{{1
function! Vimtweak#ToggleWindowCaption()
    if !exists('s:window_caption')
        let s:window_caption = 1
    endif
    if s:window_caption
        call libcallnr(g:vimtweak_dll_path, "EnableCaption", 0)
        call Vimtweak#ToggleWindowMaximize()
        call Vimtweak#ToggleWindowMaximize()
        let s:window_caption = 0
    else
        call libcallnr(g:vimtweak_dll_path, "EnableCaption", 1)
        call Vimtweak#ToggleWindowMaximize()
        call Vimtweak#ToggleWindowMaximize()
        let s:window_caption = 1
    endif
endfunction

" 切换窗口的置顶状态 -----------------------------------------------------{{{1
function! Vimtweak#ToggleWindowTopMost()
    if !exists('s:window_top_most')
        let s:window_top_most = 0
    endif
    if s:window_top_most
        call libcallnr(g:vimtweak_dll_path, "EnableTopMost", 0)
        let s:window_top_most = 0
    else
        call libcallnr(g:vimtweak_dll_path, "EnableTopMost", 1)
        let s:window_top_most = 1
    endif
endfunction
