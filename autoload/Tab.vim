function! Tab#MoveLeft()
    let l:tabnr = tabpagenr() - 2
    if l:tabnr >= 0
        exec 'tabmove '.l:tabnr
    endif
endfunc
function! Tab#MoveRight()
    let l:tabnr = tabpagenr() + 1
    if l:tabnr <= tabpagenr('$')
        exec 'tabmove '.l:tabnr
    endif
endfunc
