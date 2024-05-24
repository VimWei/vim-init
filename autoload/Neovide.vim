" 切换 Neovide 全屏状态 --------------------------------------------------{{{1
function! Neovide#ToggleFullscreen()
    if g:neovide_fullscreen
        let g:neovide_fullscreen = v:false
    else
        let g:neovide_fullscreen = v:true
    endif
endfunction
