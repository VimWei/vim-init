" 确保 wiki_root 目录存在（按需创建）-------------------------------------{{{1
function! s:EnsureWikiRoot()
    if !isdirectory(g:wiki_root)
        call mkdir(g:wiki_root, 'p')
    endif
endfunction

" 在新窗口打开 WikiIndex -------------------------------------------------{{{1
function! Wikivim#OpenWikiIndexTab()
    call s:EnsureWikiRoot()
    tabnew
    WikiIndex
    execute 'cd ' . fnameescape(g:wiki_root)
endfunction

" 不同于WikiOpen：采用相对 wikiroot 的路径，tab 打开 ---------------------{{{1
function! Wikivim#OpenWikiPage(filename)
    call s:EnsureWikiRoot()
    let l:file_to_open = g:wiki_root . a:filename
    if empty(a:filename) || !filereadable(l:file_to_open)
        let l:file_to_open = g:wiki_root . "index.md"
    endif
    execute "tabedit " . l:file_to_open
    execute 'cd ' . fnameescape(g:wiki_root)
endfunction

" Update Journal Index ---------------------------------------------------{{{1
function! Wikivim#UpdateJournalIndex()
    execute 'normal! gg'
    let searchPattern = '#\s\d\d\d\d'
    let found = search(searchPattern, 'W')
    if !found
        call append(line('$'), ['', ''])
        execute 'normal! G'
    endif
    execute 'normal! dG'
    WikiJournalIndex
    execute 'normal! gg'
endfunction

" MyUrlTransform ---------------------------------------------------------{{{1
" 将wiki链接文本转为合法且清晰的文件名
function! Wikivim#MyUrlTransform(text)
    " 删除：OS 禁用字符（Windows: * " < > | ?）与想彻底丢弃的特殊字符
    let l:stripped = substitute(a:text, '[*\?"<>|`!@#$*‘’'']', '', 'g')
    " 替换：空白、常见标点，以及 % &（本身合法，转 - 使 Pangu 加空格前后结果一致）
    let l:dashed = substitute(l:stripped, '\s\+\|[.。,，/+%&“”<>()（）《》:：]', '-', 'g')
    " 折叠：连续 - 合并为单个 -
    let l:collapsed = substitute(l:dashed, '-\+', '-', 'g')
    " 修剪：去除首尾 -
    let l:trimmed = substitute(l:collapsed, '^-\|-$', '', 'g')
    return tolower(l:trimmed)
endfunction

finish " -----------------------------------------------------------------{{{1

" 进入 wiki 后，让 pwd 转到 wiki_root
augroup wiki_vim_autochdir
    autocmd!
    autocmd BufEnter *.md,*.wiki if getbufvar(expand('%'), '&filetype') == 'markdown' | execute 'cd ' . g:wiki_root | endif
augroup END
