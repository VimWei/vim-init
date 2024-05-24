" https://www.github.com/tpope/vim-fugitive

function! g:Git_status()
    if exists('*fugitive#Head')
        return fugitive#Head()
    else
        return ''
    endif
endfunction
