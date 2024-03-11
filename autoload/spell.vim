" Spell Check

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
    " 转义 cfgfile 以便用作shell命令的参数，输出结果包含引号
    " return shellescape(cfgfile)
endfunction
" echo s:cfg('tools/conf/', 'file.cfg')

" 定义拼写检查所使用语言的列表
let g:myLangList=["nospell","en_us"]

" 在语言列表中轮询切换拼写检查
function! Spell#Toggle()
    if !exists( "b:myLang" )
        let b:myLang=0
    endif
    let b:myLang=b:myLang+1
    if b:myLang>=len(g:myLangList) | let b:myLang=0 | endif
    if b:myLang==0
        setlocal nospell
    else
        execute "setlocal spell spelllang=".get(g:myLangList, b:myLang)
        let b:mySpellfilename = substitute(&spelllang, "_.*$","","") . "." . &encoding . ".add"
        " 指定spellfile的存储地
        let b:mySpellfile = s:cfg('tools/spell/', b:mySpellfilename)
        execute "set spellfile=" . b:mySpellfile
        " execute "set spellfile?"
        " 拼写检查排除东亚字符
        execute "setlocal spelllang+=cjk"
    endif
    echo "Spell checking language:" g:myLangList[b:myLang]
endfunction
