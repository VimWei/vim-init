" 使用translator.py翻译
"
" src: https://github.com/skywind3000/translator
" Requirements: Python 3.5+ 以及 requests 库
" 安装: $ pip install requests

" 获取 vim-init 所在目录，末尾带"/"
let s:viminit = fnamemodify(resolve(expand('<sfile>:p')), ':h:h')
let s:viminit = substitute(s:viminit . '/', '\\', '/', 'g')

" 返回子目录或文件路径
function! s:cfg(path)
    let l:cfgfile = expand(s:viminit . a:path )
    let l:cfgfile = substitute(l:cfgfile, '\\', '/', 'g')
    return l:cfgfile
    " 转义 cfgfile 以便用作shell命令的参数
    " return shellescape(l:cfgfile)
endfunction

" 查询当前光标下词汇的翻译
function! Translator#Words(mode)
    let l:translator = s:cfg('tools/dict/translator.py')

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
