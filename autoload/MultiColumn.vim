" MultiColumn ------------------------------------------

" noremap <silent> <Leader>vs :<C-u>let @z=&so<CR>:set so=0 noscb<CR>:bo vs<CR>Ljzt:setl scb<CR><C-w>p:setl scb<CR>:let &so=@z<CR>

function! MultiColumn#Add()
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

function! MultiColumn#Remove()
    wincmd o    "使当前窗口成为屏幕上唯一的窗口。其它窗口都关闭。
endfunction
