" https://www.github.com/skywind3000/vim-auto-popmenu
" ins-completion 相关配置，请查看 ../essential.vim
" enable this plugin for filetypes, '*' for all files.

let g:apc_enable_ft = {'*':1}
let g:apc_enable_tab = 1
let g:apc_min_length = 2

" 定义切换命令 ToggleApc
let g:apc_enabled = 1
function! ToggleApc()
    if g:apc_enabled
        :ApcDisable
        let g:apc_enabled = 0
        echo "vim-auto-popmenu disabled"
    else
        :ApcEnable
        let g:apc_enabled = 1
        echo "vim-auto-popmenu enabled"
    endif
endfunction
command! ToggleApc call ToggleApc()
