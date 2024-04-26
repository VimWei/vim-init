"===================================================
" Statusline settings by W.Chen
" Sourced by: ../init.vim
"===================================================

set laststatus=2                                " 总是显示状态栏
set statusline=                                 " 清空状态
set statusline+=%(\ %{CurrentMode()}\ \|\ %)    " Mode：INSERT/NORMAL/VISUAL
set statusline+=%(%{BufferWinInfo()}\ \|\ %)    " Info：buffer number, winnr
set statusline+=%f%(\ %m%)                      " 文件名(相对路径)及编辑状态
set statusline+=%(\ \|\ %{g:Git_status()}%)     " git 状态
set statusline+=%=\ %<                          " 向右对齐，且窗口较小时开启截短
set statusline+=%(%{tolower(&filetype)}\ \|\ %) " 文件类型
" 最右边显示文件格式、编码和行号等信息，并且固定在一个 group 中，优先占位
set statusline+=%0(%{&fileformat}\ \|\ %{(&fenc==\"\"?&enc:&fenc).(&bomb?\",BOM\":\"\")}\ \|\ %v:%l/%L=%p%%\ %)

" 返回当前模式的名称 -----------------------------------------------------{{{1
function! CurrentMode()
    let l:mode_map = {
                \ 'n': 'NORMAL',
                \ 'no': 'N·OPERATOR PENDING',
                \ 'v': 'VISUAL',
                \ 'V': 'V·LINE',
                \ "\<C-V>": 'V·BLOCK',
                \ 's': 'SELECT',
                \ 'S': 'S·LINE',
                \ "\<C-S>": 'S·BLOCK',
                \ 'i': 'INSERT',
                \ 'R': 'REPLACE',
                \ 'Rv': 'V·REPLACE',
                \ 'c': 'COMMAND',
                \ 'cv': 'VIM EX',
                \ 'ce': 'EX',
                \ 'r': 'PROMPT',
                \ 'rm': 'MORE',
                \ 'r?': 'CONFIRM',
                \ '!': 'SHELL',
                \ 't': 'TERMINAL'
                \ }
    let l:mode = mode(1)
    if winwidth(0) > 70
        return get(l:mode_map, l:mode, 'UNKNOWN')
    elseif winwidth(0) > 35
        return l:mode
    else
        return ''
    endif
endfunction

" 显示 buffer 号和窗口号 -------------------------------------------------{{{1
function! BufferWinInfo()
    if winwidth(0) > 70
        return 'b' . bufnr('%') . 'w' . winnr()
    else
        return ''
    endif
endfunction
