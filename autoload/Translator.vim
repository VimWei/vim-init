" 使用translator.py翻译
"
" src: https://github.com/skywind3000/translator
" Requirements: Python 3.5+ 以及 requests 库
" 安装: $ pip install requests

" 查询当前光标下词汇的翻译
function! Translator#Words(mode)
    let l:translator = g:viminit . 'tools/dict/translator.py'

    if a:mode == 'v'
        let l:original_reg = getreg('z')
        normal! gv"zy
        let l:text = getreg('z')
        call setreg('z', l:original_reg)
    else
        let l:text = expand('<cword>')
    endif

    " when '!' is included, auto-scroll in quickfix will be disabled.
    execute ":AsyncRun! -strip python " . l:translator . " " . l:text
endfunction

finish
