function! Buffer#CloseDuplicateBuffers()
    " 保存当前 buffer 的编号和所在的窗口 ID
    let s:current_buffer = bufnr('%')
    let s:current_winid = win_getid()

    " 记录每个 buffer 打开的所有窗口 ID
    let l:buffer_windows = {}
    for l:tabnr in range(1, tabpagenr('$'))
        for l:winnr in range(1, tabpagewinnr(l:tabnr, '$'))
            let l:winid = win_getid(l:winnr, l:tabnr)
            let l:bufnr = winbufnr(l:winid)
            if l:bufnr == -1
                continue
            endif
            if !has_key(l:buffer_windows, l:bufnr)
                let l:buffer_windows[l:bufnr] = []
            endif
            call add(l:buffer_windows[l:bufnr], l:winid)
        endfor
    endfor

    " 关闭重复打开的 buffer
    for l:bufnr in keys(l:buffer_windows)
        let l:winids = l:buffer_windows[l:bufnr]
        if len(l:winids) <= 1
            continue
        endif
        " 确定要保留的窗口
        let l:keep_winid = s:current_buffer == l:bufnr ? s:current_winid : l:winids[0]
        for l:winid in l:winids
            if l:winid != l:keep_winid
                " 如果窗口在只有单个窗口的 tab 中，关闭整个 tab
                let l:tabnr = win_id2tabwin(l:winid)[0]
                if tabpagewinnr(l:tabnr, '$') == 1
                    execute l:tabnr . 'tabclose'
                else
                    call win_gotoid(l:winid)
                    execute 'wincmd c'
                endif
            endif
        endfor
    endfor

    " 激活最初保存的 buffer 所在的窗口
    call win_gotoid(s:current_winid)
endfunction
