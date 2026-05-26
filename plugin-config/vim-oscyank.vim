"===================================================
" OSC 52 剪贴板自动同步配置
" 适用于终端 Vim（非 gvim、非 neovim），如 SSH 远程服务器
"===================================================

augroup osc_yank
    autocmd!
    autocmd TextYankPost * call s:OSCYankPost()
augroup END

function! s:OSCYankPost()
    if v:event.operator is 'y' && v:event.regname is ''
        call OSCYankRegister('')
    endif
endfunction
