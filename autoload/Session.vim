function! Session#MK(...)
    " 配置默认session的保存位置
    let default_session = '~/vimfiles/session/main.vim'
    " 检查目录是否存在，如果不存在则创建
    if !isdirectory(fnamemodify(expand(default_session), ':h'))
        call mkdir(session_dir, 'p')
    endif
    if a:0 > 0 && !empty(a:1)
        if a:1 == 'mk'
            " 保存 session
            execute 'mksession! ' . default_session
            echom 'Success in executing :mksession! ' . default_session
        elseif a:1 == 'so'
            " 加载 session
            if filereadable(expand(default_session))
                execute 'source ' . default_session
                echom 'Success in executing :source ' . default_session
            else
                echoerr 'Session file does not exist.'
            endif
        endif
    endif
endfunction
