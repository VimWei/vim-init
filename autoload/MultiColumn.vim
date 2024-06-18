" MultiColumn ------------------------------------------

" noremap <silent> <Leader>vs :<C-u>let @z=&so<CR>:set so=0 noscb<CR>:bo vs<CR>Ljzt:setl scb<CR><C-w>p:setl scb<CR>:let &so=@z<CR>

function! MultiColumn#On()
    " clear command line (if in visual mode)
    exe "norm! \<Esc>"
    let @z=&so          " save scrolloff in register z
    set so=0 noscb      " set scrolloff to 0 and clear scrollbind
    " mark当前位置\当前页面底部行\回文档第一行
    exe "norm! mmLmngg"
    bo vs               " split window vertically, new window on right
    " jump to bottom of window + 1, scroll to top
    exe "norm! Ljzt"
    setl scrollbind     " setlocal scrollbind in right window
    wincmd p            " jump to previous window
    setl scrollbind     " setlocal scrollbind in left window
    let &so=@z          " restore scrolloff
    " 跳到mark n\将mark n所在的行放在屏幕底部\将光标恢复至初始位置mark m
    exe "norm! `nzb`m"
endfunction

function! MultiColumn#Off()
    wincmd o    "使当前窗口成为屏幕上唯一的窗口。其它窗口都关闭。
endfunction

function! MultiColumn#Toggle()
    " 检查当前窗口数量
    if winnr('$') > 1
        " 如果窗口数量大于1，假设多列模式已开启，因此关闭它
        call MultiColumn#Off()
    else
        " 如果只有一个窗口，假设多列模式未开启，因此开启它
        call MultiColumn#On()
    endif
endfunction
