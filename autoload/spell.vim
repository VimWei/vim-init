" Spell Check

" 定义拼写检查所使用语言的列表
let s:myLangList=["nospell","en_us"]

" 在语言列表中轮询切换拼写检查
function! Spell#Toggle()
    if !exists( "b:myLang" )
        let b:myLang=0
    endif
    let b:myLang=b:myLang+1
    if b:myLang>=len(s:myLangList) | let b:myLang=0 | endif
    if b:myLang==0
        setlocal nospell
    else
        execute "setlocal spell spelllang=".get(s:myLangList, b:myLang)
        let b:mySpellfilename = substitute(&spelllang, "_.*$","","") . "." . &encoding . ".add"
        " 指定spellfile的存储地
        let b:mySpellfile = g:viminit . 'tools/spell/' . b:mySpellfilename
        execute "set spellfile=" . b:mySpellfile
        " execute "set spellfile?"
        " 拼写检查排除东亚字符
        execute "setlocal spelllang+=cjk"
    endif
    echo "Spell checking language:" s:myLangList[b:myLang]
endfunction
