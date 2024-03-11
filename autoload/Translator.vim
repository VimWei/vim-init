" 使用translator.py翻译
"
" src: https://github.com/skywind3000/translator
" Requirements: Python 3.5+ 以及 requests 库
" 安装: $ pip install requests

" 获取 vim-init 所在目录，不带末尾的"/"
let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h:h')

" 返回tools所在路径 "s:home/path"；末尾是否包含"/"取决于path参数
function! s:path(path)
	let l:path = expand(s:home . '/' . a:path )
	return substitute(l:path, '\\', '/', 'g')
endfunction
" echo s:path('tools/conf/')

" 返回文件路径 "s:home/path/name"；为便于理解，要求path参数带末尾的"/"
function! s:cfg(path, name)
    let l:cfgpath = s:path(a:path)
    let l:cfgfile = l:cfgpath . a:name
    return l:cfgfile
    " 转义 cfgfile 以便用作shell命令的参数
    " return shellescape(cfgfile)
endfunction
" echo s:cfg('tools/conf/', 'file.cfg')

" 查询当前光标下词汇的翻译
function! Translator#PyNormal(path, name)
    let l:translator = s:cfg(a:path, a:name)
    " when '!' is included, auto-scroll in quickfix will be disabled.
    execute ":AsyncRun! -strip python " . l:translator . " <cword>"
endfunction

" 查询选中内容的翻译
function! Translator#PyVisual(path, name)
    let l:translator = s:cfg(a:path, a:name)
    let l:selection = @0
    " when '!' is included, auto-scroll in quickfix will be disabled.
    execute ":AsyncRun! -strip python " . l:translator . " ". l:selection
endfunction

finish

" 推荐如下映射配置，使用了autoload函数延时加载特性，提升效率
nnoremap <leader>dt :call Translator#PyNormal('tools/dict/', 'translator.py')<CR>
vnoremap <leader>dt y:call Translator#PyVisual('tools/dict/', 'translator.py')<CR>

" 以下映射配置虽然简洁，但是多定义了一个全局变量
let translator = s:cfg('tools/dict/', 'translator.py')
nnoremap <leader>dt :exe ":AsyncRun! -strip python " . translator . " <cword>"<CR>
vnoremap <leader>dt y:exe ":AsyncRun! -strip python " . translator . " <C-r>0"<CR>
