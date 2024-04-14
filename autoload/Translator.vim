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
function! Translator#PyNormal(path)
    let l:translator = s:cfg(a:path)
    " when '!' is included, auto-scroll in quickfix will be disabled.
    execute ":AsyncRun! -strip python " . l:translator . " <cword>"
endfunction

" 查询选中内容的翻译
function! Translator#PyVisual(path)
    let l:translator = s:cfg(a:path)
    let l:selection = @0
    " when '!' is included, auto-scroll in quickfix will be disabled.
    execute ":AsyncRun! -strip python " . l:translator . " ". l:selection
endfunction

finish

" 推荐如下映射配置，使用了autoload函数延时加载特性，提升效率
nnoremap <leader>dt :call Translator#PyNormal('tools/dict/translator.py')<CR>
vnoremap <leader>dt y:call Translator#PyVisual('tools/dict/translator.py')<CR>

" 以下映射配置虽然简洁，但是多定义了一个全局变量
let translator = s:cfg('tools/dict/', 'translator.py')
nnoremap <leader>dt :exe ":AsyncRun! -strip python " . translator . " <cword>"<CR>
vnoremap <leader>dt y:exe ":AsyncRun! -strip python " . translator . " <C-r>0"<CR>
